#!/bin/bash
BIN=$1
if [ -z "${BIN}" ] ; then
    echo USAGE: run_test.sh [binary_path] [source_path]
    exit 1
fi
set -u
ec=0
total=0
accepted=0
for IN_FILE in `ls ./test/*.in` ; do
    echo running `basename ${BIN}` for `basename ${IN_FILE}`
    if [ ! -s ${IN_FILE} ]; then
        echo "IN_FILE IS EMPTY"
        continue
    fi
    ((total++))
    OUT_FILE=${IN_FILE/in/out}
    ${BIN} < ${IN_FILE} >> tmp.txt
    diff ${OUT_FILE} tmp.txt --strip-trailing-cr > /dev/null
    rc=$?
    if [ ${rc} -ne 0 ] ; then
        ec=1
        echo !!!---failed test for${IN_FILE}---!!!
        echo input:
        cat ${IN_FILE}
        echo output:
        cat tmp.txt
        echo expected:
        cat ${OUT_FILE}
    else
        echo AC
        ((accepted++))
    fi
    rm tmp.txt
done
echo ${accepted}/${total} are AC
if [[ ${accepted} == ${total} ]]; then
    python ../expand.py
    echo clipping source code
		clang-format tmp.cpp > a.cpp
    cat a.cpp | clip
		rm tmp.cpp
fi
exit ${ec}
