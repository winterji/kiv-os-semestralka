cd sources/userspace
./build.sh
cd ..
rm -r build
echo "Build directory removed"
./build.sh
echo "Build directory rebuilt"