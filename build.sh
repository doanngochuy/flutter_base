set -e

#fvm flutter build apk -t lib/main_prod.dart --release
#echo "Build apk Done !!!"
#
fvm flutter build appbundle -t lib/main_prod.dart --release
echo "Build bundle Done !!!"

fvm flutter build ipa -t lib/main_prod.dart --release
echo "Build ipa Done !!!"

#flutter build web -t lib/main_prod.dart --release
#echo "Build ipa Done !!!"
