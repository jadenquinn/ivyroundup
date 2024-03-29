#!/bin/sh
# $Id$

#
# This script should be used to regenerate the repository
#

# Bail on errors, show commands
set -e

# Set locale
export LANG=C
export LC_ALL=C

# Use the right sed(1) flag
case "`uname -s`" in
    Darwin|FreeBSD)
        SEDFLAG="-E"
        ;;
    *)
        SEDFLAG="-r"
        ;;
esac

# Subroutine
regenerate_repo()
{
    # Regenerate repo
    echo 'regenrepo: regenerating repository' "$1"
    ant -Djavax.xml.transform.TransformerFactory=org.apache.xalan.processor.TransformerFactoryImpl \
      -Ddownload-xalan=true repo > regen.out

    # Check for errors (fatal)
    if grep -q ERROR regen.out; then
        echo 'regenrepo: ERROR: errors found during repository generation:'
        grep ERROR regen.out
        rm -f regen.out
        exit 1
    fi

    # Check for warnings (non-fatal)
    if grep -q WARNING regen.out; then
        echo 'regenrepo: warnings found during repository generation:'
        grep WARNING regen.out
    fi
    rm -f regen.out
}

# Revert any changes to existing repo
svn revert -R repo/

# Update to get lastest stuff
echo 'regenrepo: updating from SVN'
svn up

# There should be no outstanding changes
echo 'regenrepo: checking status of source'
if ! [ "`svn st src | wc -c`" -eq 0 ]; then
    echo 'regenrepo: WARNING: src/ is not clean; do not commit generated repository:'
    svn st src
fi

# Regenerate repo (first time)
regenerate_repo

# If there's anything new, svn copy it from source
if svn st repo/modules 2>/dev/null | grep '^\?'; then

    # Do the copy
    echo 'regenrepo: svn copying new stuff into repository'
    svn st repo/modules \
      | grep '^\?' \
      | awk '{print $2}' \
      | sed ${SEDFLAG} 's/^repo\///g' \
      | while read NAME; do
        rm -rf repo/$NAME
        svn cp src/$NAME repo/$NAME
        svn pd --recursive --quiet svn:mergeinfo repo/$NAME || true
        svn pd --recursive --quiet svn:keywords  repo/$NAME || true
    done

    # Regenerate repo (second time)
    regenerate_repo '(again)'
fi

# If any directories have been removed from the source tree, remove them from the generated repo
( cd repo/modules && find . -mindepth 1 -maxdepth 3 -type d | grep -vF .svn \
  | xargs -n 1 -I '{}' sh -c 'test -d ../../src/modules/{} || echo {}' ) | sort -r | while read DIR; do
    echo "regenrepo: removing deleted directory ${DIR}"
    svn rm repo/modules/"${DIR}"
done

# Fixup MIME types
echo "regenrepo: fixing up MIME types"
find repo -type f -name '*.xml' -print0 | xargs -0 svn ps svn:mime-type text/xml

# Done
echo 'regenrepo: done'
