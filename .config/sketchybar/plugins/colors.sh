# Colors
c_green=0xffd6fecb
c_blue=0xffcbfefe
c_yellow=0xfff6fecb
c_red=0xfffecbcb
c_white=0xffffffff
c_orange=0xffffdca8

set_env_color () {
  case "$1" in
    *dev* ) env_color=$c_green ;;
    *test* ) env_color=$c_blue ;;
    *stage* ) env_color=$c_yellow ;;
    *prod* ) env_color=$c_red ;;
    * ) env_color=$c_white ;;
  esac
}
