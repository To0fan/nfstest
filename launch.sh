THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

bot_config() {
  mkdir -p "$THIS_DIR"/data/telegram-cli
  printf '%s\n' "
default_profile = \"default\";

default = {
  config_directory = \"$THIS_DIR/data/telegram-cli\";
  auth_file = \"$THIS_DIR/data/telegram-cli/auth\";
  test = false;
  msg_num = true;
  log_level = 2;
};
" > "$THIS_DIR"/data/bot/bot.config
}

install() {
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get install g++-4.7 c++-4.7
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev lua-socket lua-sec lua-expat libevent-dev make unzip git redis-server autoconf g++ libjansson-dev libpython-dev expat libexpat1-dev
sudo apt-get install screen
sudo apt-get install tmux
wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz
 tar zxpf luarocks-2.2.2.tar.gz
 mv luarocks-2.2.2 luarocks
 rm -rf 'luarocks-2.2.2.tar.gz'
 cd luarocks
 ./configure; sudo make bootstrap
 sudo luarocks install luasocket
 sudo luarocks install luasec
 sudo luarocks install redis-lua
 sudo luarocks install lua-term
 sudo luarocks install serpent
 sudo luarocks install dkjson
 sudo luarocks install lanes
 sudo luarocks install Lua-cURL
 cd $home
 cd Nfs
  wget https://valtman.name/files/telegram-cli-1124
mv telegram-cli-1124 tg
chmod +x tg
  cd ..
 bot_config
}

if [ "$1" = "install" ]; then
  install
else
  while true; do
  bot_config
  ./tg -s ./data/bot/bot.lua -l 1 -E -c ./data/bot/bot.config -p default "$@"
   sleep 3
  done
fi
