import * as std from "quickjs:std";
import * as os from "quickjs:os";

function usage() {
  std.err.puts(
    "Pipe a JSON array into this program to join its items with a delimiter\n"
  );
  std.exit(1);
}

if (os.isatty(std.in.fileno())) {
  usage();
}

const input = std.in.readAsString();

if (input.length === 0) {
  usage();
}

function getDelim() {
  const args = scriptArgs.slice(1);
  const argsString = args.join(" ");

  if (argsString.length == 0) {
    return " ";
  }

  if (argsString.match(/^(?:\\[bfnrtv])+$/)) {
    const value = new Function(`return "${argsString}"`)();
    return value;
  }

  if (argsString.match(/^".*"$/) || argsString.match(/^'.*'$/)) {
    const value = new Function(`return ${argsString}`)();
    return value;
  }

  return argsString;
}

const array = JSON.parse(input);
const delim = getDelim();

const result = array.join(delim);

std.out.puts(result);
