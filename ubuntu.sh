set -e

case $BASH_SOURCE in
  *.sh) cwd=$(dirname $BASH_SOURCE) ;;
  *)    cwd=$(dirname $0) ;;
esac

# order matters
cd $cwd
cp -R -n ./cp/. $HOME
. setup/zsh
. install/go
. install/node
. install/python

# install on request
for arg; do
  software=$arg
  case $software in
    tf) software=tensorflow ;;
  esac

  install_script="install/${software}"
  if [ -x $install_script ]; then
    . $install_script
  fi
done

cd - > /dev/null

# print results
echo -e '\nCurrent environment:\n'
echo "http_proxy=${http_proxy}"
echo "https_proxy=${https_proxy}"
zsh --version
go version
echo "node $(node -v)"
python3 --version
pip3 --version
echo -e '\nAll done.\n'
