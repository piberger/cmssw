tar xvzf python.tar.gz --directory $CMSSW_BASE
ls -lR .
echo "ENV..................................."
env
echo "VOMS"
voms-proxy-info -all
echo "CMSSW BASE, python path, pwd"
echo $CMSSW_BASE 
echo $PYTHON_PATH
echo $PWD 
rm -rf $CMSSW_BASE/lib/
rm -rf $CMSSW_BASE/src/
#rm -rf $CMSSW_BASE/module/
#rm -rf $CMSSW_BASE/python/
#rm -rf $CMSSW_BASE/interface/
#mv interface $CMSSW_BASE/interface/
mv lib $CMSSW_BASE/lib
mv src $CMSSW_BASE/src
#mv module $CMSSW_BASE/module
#mv python $CMSSW_BASE/python

echo Found Proxy in: $X509_USER_PROXY
MD5SUM=`cat heppy_config.py | md5sum | awk '{print $1}'`

cat <<EOF > fakeprov.txt
Processing History:
 HEPPY '' '"CMSSW_X_y_Z"' [1]  ($MD5SUM)
EOF

cat <<EOF > $CMSSW_BASE/bin/$SCRAM_ARCH/edmProvDump
#!/bin/sh
cat fakeprov.txt
EOF

chmod +x $CMSSW_BASE/bin/$SCRAM_ARCH/edmProvDump

echo "Which edmProvDump"
which edmProvDump
edmProvDump


# Update library path
# Needed so recompiled modules are found
#export LD_LIBRARY_PATH=./lib/slc6_amd64_gcc481:$LD_LIBRARY_PATH 
cd $CMSSW_BASE
eval `scram runtime -sh`
cd -
echo "LD LIBRARY PATH IS"
echo $LD_LIBRARY_PATH

export ROOT_INCLUDE_PATH=.:./src:$ROOT_INCLUDE_PATH


python heppy_crab_script.py $1
echo "======================== CMSRUN LOG ============================"
head -n 30 Output/cmsRun.log 
echo "=== SNIP ==="
tail -n 500 Output/cmsRun.log 
