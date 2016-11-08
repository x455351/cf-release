common_name=''
depot_path=''
output_path=''

show_help() {
  echo "Usage: generate_ca_cert [OPTIONS]"
  echo "Output Options:"
  echo "  -c --common-name [REQUIRED]     The common name for the CA"
  echo "  -d --depot-path  [REQUIRED]     The depot path (where all files will be written to) for the CA"
  echo "  -o --output-file [REQUIRED]     The output file name of the CA cert and key"
  echo "  -h --help            Show a help message"
  exit 0
}

while true; do
  case "$1" in
    -c | --common-name ) common_name="$2"; shift 2;;
    -d | --depot-path ) depot_path="$2"; shift 2;;
    -o | --output-file ) output_path="$2"; shift 2 ;;
    -h | --help )
      show_help ;;
    * ) break ;;
  esac
done

if [ "${common_name}" == "" -o "${depot_path}" == "" -o "${output_path}" == "" ]; then
  show_help
fi

certstrap --depot-path "${depot_path}" init --passphrase '' --common-name "${common_name}"
mv -f "${depot_path}/$common_name.crt" "${depot_path}/$output_path.crt"
mv -f "${depot_path}/$common_name.key" "${depot_path}/$output_path.key"
mv -f "${depot_path}/$common_name.crl" "${depot_path}/$output_path.crl"
