#!/bin/sh

set -eu


# iterations

iterations=2


# tmp

tmp=$(mktemp -d)

if [ -d "${1-}" ]
then
  find "$1" -type f -name "*.gif" -exec cp {} "$tmp" \;
  find "$1" -type f -name "*.jpg" -exec cp {} "$tmp" \;
  find "$1" -type f -name "*.png" -exec cp {} "$tmp" \;
  find "$1" -type f -name "*.svg" -exec cp {} "$tmp" \;
fi

cd "$tmp"


# commands

cat > gif.txt <<'EOF'
  gifsicle,,"$input" -o "$output"
  gifsicle,-O1,"$input" -o "$output"
  gifsicle,-O2,"$input" -o "$output"
gifsicle,-O3,"$input" -o "$output"
EOF

cat > jpg.txt <<'EOF'
  guetzli,,"$input" "$output"
  guetzli,--quality 84,"$input" "$output"
  guetzli,--quality 95,"$input" "$output"

mozjpeg-cjpeg,,"$input" > "$output"
  mozjpeg-cjpeg,-quality 75,"$input" > "$output"
  mozjpeg-cjpeg,-quality 90,"$input" > "$output"
EOF

cat > png.txt <<'EOF'
  advdef,-z1,"$output"
  advdef,-z2,"$output"
  advdef,-z3,"$output"
advdef,-z4,"$output"

  advpng,-z1,"$output"
  advpng,-z2,"$output"
  advpng,-z3,"$output"
  advpng,-z4,"$output"

  ect,,"$output"
  ect,-1 -s,"$output"
  ect,-2 -s,"$output"
  ect,-3 -s,"$output"
  ect,-4 -s,"$output"
  ect,-5 -s,"$output"
  ect,-6 -s,"$output"
  ect,-7 -s,"$output"
  ect,-8 -s,"$output"
  ect,-9 -s,"$output"

  optipng,,"$output"
  optipng,-o1,"$output"
  optipng,-o2,"$output"
  optipng,-o3,"$output"
  optipng,-o4,"$output"
  optipng,-o5,"$output"
  optipng,-o6,"$output"
optipng,-o7,"$output"

  oxipng,,"$output"
  oxipng,-o1,"$output"
  oxipng,-o2,"$output"
  oxipng,-o3,"$output"
  oxipng,-o4,"$output"
  oxipng,-o5,"$output"
  oxipng,-o6,"$output"
  oxipng,-o6 -Z,"$output"

  pingo,-s1,"$output"
  pingo,-s2,"$output"
  pingo,-s3,"$output"
  pingo,-s4,"$output"
  pingo,-s5,"$output"
  pingo,-s6,"$output"
  pingo,-s7,"$output"
  pingo,-s8,"$output"

  pngcrush,,"$input" "$output"

  pngoptimizercl,,"$output"

  pngout,,"$input" "$output"

  pngquant,,"$output"

  pngwolf,,--in="$input" --out="$output"
  pngwolf,--estimator=libdeflate,--in="$input" --out="$output"
  pngwolf,--estimator=zlib,--in="$input" --out="$output"
  pngwolf,--estimator=zopfli,--in="$input" --out="$output"

  truepng,,"$output"
  truepng,-o4,"$output"

  zopflipng,,"$input" "$output"
  zopflipng,-m,"$input" "$output"
  zopflipng,--iterations=10,"$input" "$output"
  zopflipng,--iterations=100,"$input" "$output"
  zopflipng,--iterations=1000,"$input" "$output"
EOF

cat > svg.txt <<'EOF'
scour,,"$input" "$output"

svgcleaner,,"$input" "$output"

svgo,,-i "$input" -o "$output"
EOF

cat > sim.txt <<'EOF'
butteraugli,butteraugli,"$1" "$2" 2>/dev/null

ssimulacra,ssimulacra,"$1" "$2" 2>/dev/null

ssim,compare,-metric ssim "$1" "$2" null: 2>&1
dssim,compare,-metric dssim "$1" "$2" null: 2>&1
psnr,compare,-metric psnr "$1" "$2" null: 2>&1
mae,compare,-metric mae "$1" "$2" null: 2>&1
fuzz,compare,-metric fuzz "$1" "$2" null: 2>&1
ncc,compare,-metric ncc "$1" "$2" null: 2>&1
EOF


# https://en.wikipedia.org/wiki/Standard_test_image

# gif

wget "https://imgs.xkcd.com/comics/slideshow.gif"
# wget "https://imgs.xkcd.com/comics/eternal_flame.gif"


# jpg

wget "https://imgs.xkcd.com/comics/schrodinger.jpg"

# wget "https://assets.toggl.com/images/toggl-how-to-save-the-princess-in-8-programming-languages.jpg"
# wget "https://toggl.com/blog/wp-content/uploads/2017/04/toggl-how-to-kill-the-dragon-with-9-programming-languages.jpg"
# wget "https://toggl.com/blog/wp-content/uploads/2018/08/toggl-how-to-create-horse-with-programming.jpg"

# wget "https://upload.wikimedia.org/wikipedia/commons/6/6a/Mona_Lisa.jpg"
# wget "https://upload.wikimedia.org/wikipedia/commons/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg"

# png

# wget "http://r0k.us/graphics/kodak/kodak/kodim01.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim02.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim03.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim04.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim05.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim06.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim07.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim08.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim09.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim10.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim11.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim12.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim13.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim14.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim15.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim16.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim17.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim18.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim19.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim20.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim21.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim22.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim23.png"
# wget "http://r0k.us/graphics/kodak/kodak/kodim24.png"

wget "http://www.bluebison.net/llama/wp-content/uploads/2017/12/dachshund.png"
# wget "http://www.bluebison.net/llama/wp-content/uploads/2017/12/rabbit_vectorized.png"
# wget "http://www.bluebison.net/llama/wp-content/uploads/2017/12/chameleon.png"
# wget "http://www.bluebison.net/llama/wp-content/uploads/2017/12/sheep-coffee.png"
# wget "http://www.bluebison.net/llama/wp-content/uploads/2017/12/monkey-riding-a-mammoth.png"

# wget "https://imgs.xkcd.com/comics/random_number.png"
# wget "https://imgs.xkcd.com/comics/good_code.png"
# wget "https://imgs.xkcd.com/comics/standards.png"
# wget "https://imgs.xkcd.com/comics/password_strength.png"
# wget "https://imgs.xkcd.com/comics/star_ratings.png"

# wget "http://s3.amazonaws.com/theoatmeal-img/comics/definitely/definitely.png"
# wget "http://s3.amazonaws.com/theoatmeal-img/comics/cats_schrodinger/cats_schrodinger.png"

# svg

wget "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/car.svg"


# https://github.com/nathanaeljones/imaging-wiki

imagemagick="imagemagick $(magick -version | awk 'NR==1{print $3}')"

# https://en.wikipedia.org/wiki/GIF

gifsicle="gifsicle $(gifsicle --version | awk 'NR==1{print $3}')"

# https://en.wikipedia.org/wiki/JPEG

guetzli="guetzli 1.0.1"
jpegrecompress="jpegrecompress $(jpeg-recompress -V)"
jpegoptim="jpegoptim $(jpegoptim -V | awk 'NR==1{print substr($2,2)}')"
jpegtran="jpegtran $(jpegtran -version 2>&1 | awk '{print $3}')"
mozjpegcjpeg="mozjpeg $(mozjpeg-cjpeg -version 2>&1 | awk '{print $3}')"

# https://en.wikipedia.org/wiki/Portable_Network_Graphics

advdef="advdef $(advdef -V | awk '{print substr($2,2)}')"
advpng="advpng $(advpng -V | awk '{print substr($2,2)}')"
ect="ect $(ect | awk '/Version/{print $2}')"
optipng="optipng $(optipng -V | awk '/OptiPNG version/{print $3}')"
oxipng="oxipng $(oxipng -V | awk '{print $2}')"
# pingo="pingo $(pingo -V | awk '/pingo v/{print substr($2,2)}')"
pngcrush="pngcrush $(pngcrush -version 2>&1 | awk -F' ' '/pngcrush/{print substr($2,1,length($2)-1)}')"
pngoptimizercl="pngoptimizercl $(pngoptimizercl | awk 'NR==1{print $2}')"
pngout="pngout 20200115"
pngquant="pngquant $(pngquant -V | awk '{print $1}')"
pngwolf="pngwolf $(pngwolf --version | awk 'NR==1{print $2}')"
# truepng="truepng $(truepng | awk 'NR==1{print $2}')"
zopflipng="zopflipng 1.0.3"

# https://en.wikipedia.org/wiki/Scalable_Vector_Graphics

scour="scour $(scour --version)"
svgcleaner="svgcleaner $(svgcleaner --version | awk '{print $2}')"
svgo="svgo $(svgo -v)"

# https://en.wikipedia.org/wiki/Structural_similarity

butteraugli="butteraugli 71b18b6"
compare="compare $(compare -version | awk 'NR==1{print $3}')"
ssimulacra="ssimulacra 375726b"


# https://stackoverflow.com/questions/16414410/delete-empty-lines-using-sed
# https://stackoverflow.com/questions/8206280/delete-all-lines-beginning-with-a-from-a-file
# https://stackoverflow.com/questions/4286469/how-to-parse-a-csv-file-in-bash
# http://www.tldp.org/LDP/abs/html/ivr.html
# https://unix.stackexchange.com/questions/30173/how-to-remove-duplicate-lines-inside-a-text-file
# https://unix.stackexchange.com/questions/104881/remove-particular-characters-from-a-variable-using-bash

uname -a > result.txt
echo >> result.txt

trim() {
  mv "$1" tmp.txt
  touch "$1"

  sed -i '/^\s*$/d' tmp.txt
  sed -i '/^ /d' tmp.txt

  while IFS=, read -r command options arguments
  do
    if command -v "$command" >/dev/null 2>&1
    then
      printf '%s,%s,%s\n' "$command" "$options" "$arguments" >> "$1"

      if ! grep -qw "$command" result.txt
      then
        eval string="\$$(printf '%s' "$command" | tr -d -)"
        printf '%s\n' "$string" >> result.txt
      fi
    else
      printf '\033[91m%s\n\n\033[0m' "$command not available"
    fi
  done < tmp.txt

  rm tmp.txt
}

trim gif.txt
trim jpg.txt
trim png.txt
trim svg.txt

echo >> result.txt


# https://stackoverflow.com/questions/11117493/how-to-delete-the-rows-that-start-with-c-with-awk
# https://stackoverflow.com/questions/16414410/delete-empty-lines-using-sed
# https://stackoverflow.com/questions/14634349/calling-an-executable-program-using-awk
# https://stackoverflow.com/questions/20646819/how-can-i-pass-variables-from-awk-to-a-shell-command

awk -F, '/^[[:alpha:]]/{if(!system("command -v "$2" >/dev/null 2>&1")){print}}' sim.txt > sim.csv


# https://chris-lamb.co.uk/posts/joining-strings-in-posix-shell
# https://unix.stackexchange.com/questions/444946/how-can-we-run-a-command-stored-in-a-variable
# https://unix.stackexchange.com/questions/416571/why-is-using-eval-necessary-to-pass-quoted-arguments
# https://stackoverflow.com/questions/13122441/how-do-i-read-a-variable-on-a-while-loop

sim() {
  test=""
  line=""

  while IFS=, read -r name command arguments
  do
    test="${test:+${test},}${name}"
    eval="$(eval "$command $arguments" || true)"
    line="${line:+${line},}${eval:- }"
  done < sim.csv
}


# https://unix.stackexchange.com/questions/162619/to-print-execution-time-of-script-from-script
# https://stackoverflow.com/questions/16959337/usr-bin-time-format-output-elapsed-time-in-milliseconds

tick() { tick=$(date +%s%N); }
tock() { awk "BEGIN{print ($(date +%s%N)-$tick)/1000000000}"; }


# https://stackoverflow.com/questions/16896369/show-elapsed-time-every-second-running-a-bash-script
# https://stackoverflow.com/questions/5861428/bash-script-erase-previous-line

one() {
  s=0
  while [ -e "$1" ]
  do
    printf '%s %ss\033[0K\r' "$2" "$s"
    sleep 1
    s=$((s + 1))
  done
}

two() {
  rm -f "$1"
}


# https://stackoverflow.com/questions/25461806/how-to-print-a-range-of-columns-in-a-csv-in-awk
# https://unix.stackexchange.com/questions/193324/sort-and-uniq-in-awk
# https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell-variables-with-a-single-command-in-bash
# https://stackoverflow.com/questions/48218775/whats-the-difference-between-and-in-bash-parameter-substitution
# https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02

score() {
  awk -v FS="," -v OFS="," -v image="$1" -v test="${test:-}" '
  $1 == image {
    if (p < 1) {
      print "command","number","size","saving","time",test
      p++
    }

    for (i = 4; i <= NF; i++) { printf "%s%s", $i, (i < NF ? OFS : ORS) | "sort -t, -k4gr -k5g -k2g" }
  }
  ' output.txt
}

total() {
  awk -v FS="," -v OFS="," -v f="$f" '
  {
    format[$4] = $2
    number[$4] = $5
    processed[$4]++
    if ($7 > 0) { compressed[$4]++ }
    size[$4] += $6
    saving[$4] += $7
    time[$4] += $8
  }

  END {
    if (NR > 0) {
      print "command,number,processed,compressed,size,saving,time"

      for (i in processed) {
        if (format[i] == f) {
          print i,number[i],processed[i]+0,compressed[i]+0,size[i],saving[i]/processed[i],time[i] | "sort -t, -k6gr -k7g -k2g -k4g"
        }
      }
    }
  }
  ' output.txt
}


# https://unix.stackexchange.com/questions/318755/shell-customize-the-color-of-each-line-of-a-log-file-based-on-a-pattern
# https://unix.stackexchange.com/questions/340091/why-the-output-of-column-is-misaligned-with-a-ansi-colored-input
# https://stackoverflow.com/questions/11454343/pipe-output-to-bash-function
# https://stackoverflow.com/questions/34497884/writing-a-shell-function-that-accepts-input-from-a-pipe-and-arguments-simultaneo

# https://github.com/seebi/dircolors-solarized
# https://en.wikipedia.org/wiki/ANSI_escape_code
# http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

separate() {
  awk -v FS="," -v OFS=",\x1F" '
  {
    for (i = 1; i <= NF; i++) { printf "%s%s", $i, (i < NF ? OFS : ORS) }
  }
  '
}

colorize() {
  awk -v FS="\x1F" '
  function color(c, s) {
    printf "\033[38;5;%dm%s\033[0m\n", c, s
    next
  }

  NR == 1 { color(33, $0) }
  $2 == 1 { color(255, $0) }
  $2 == 2 { color(245, $0) }
  $2 == 3 { color(240, $0) }
  { color(240, $0) }
  '
}


# https://dwheeler.com/essays/filenames-in-shell.html
# https://stackoverflow.com/questions/39319539/what-is-the-most-portable-way-to-write-an-iteration-for-while-loop-in-a-posi
# https://davidwalsh.name/first-frame-animated-gif
# https://imagemagick.org/script/identify.php
# https://imagemagick.org/script/escape.php
# https://imagemagick.org/script/command-line-processing.php
# https://imagemagick.org/script/formats.php

for file in ./*
do
  mimetype=$(file --brief --mime-type "$file")

  if [ "$mimetype" = "image/gif" ] || [ "$mimetype" = "image/jpeg" ] || [ "$mimetype" = "image/png" ] || [ "$mimetype" = "image/svg+xml" ]
  then
    if identify "${file}[0]" >/dev/null 2>&1
    then
      image="$(identify -format "%f" "${file}[0]")"
      name="$(identify -format "%t" "${file}[0]")"
      format="$(identify -format "%m" "${file}[0]")"
      size="$(wc -c < "$file")"
      dimensions="$(identify -format "%G" "${file}[0]")"
      type="$(identify -format "%[type]" "${file}[0]")"
      colorspace="$(identify -format "%[colorspace]" "${file}[0]")"
      colors="$(identify -format "%k" "${file}[0]")"
      depth="$(identify -format "%z-bit" "${file}[0]")"
      compression="$(identify -format "%C" "${file}[0]")"
      entropy="$(identify -format "%[entropy]" "${file}[0]")"

      printf '%s\n' "$image,$name,$format,$size,$dimensions,$type,$colorspace,$colors,$depth,$compression,$entropy" >> input.txt
    fi
  fi
done

if [ ! -f input.txt ]
then
  printf '\033[91m%s\n\033[0m' "no images found"
  exit 1
fi


# https://unix.stackexchange.com/questions/102008/how-do-i-trim-leading-and-trailing-whitespace-from-each-line-of-some-output
# https://stackoverflow.com/questions/20262869/why-does-1-in-awk-print-the-current-line
# https://unix.stackexchange.com/questions/118433/quoting-within-command-substitution-in-bash
# https://www.tecmint.com/empty-delete-file-content-linux/
# https://www.regular-expressions.info/wordboundaries.html
# https://stackoverflow.com/questions/30224018/imagemagick-compare-exit-code-1-when-spawned-from-node-js-but-exit-code-0-when

start() {
  number="$1"
  image="$2"
  format="$3"
  command="$4"
  options="$5"
  arguments="$6"
  input="$7"
  output="$8"
  copy="$9"

  if grep -q ",$output," output.txt
  then
    printf '%s\n' "$output" >> out.txt
    return
  fi

  if grep -q ",$input,.*$command" output.txt
  then
    return
  fi

  if [ "$copy" -eq 1 ]
  then
    cp "$input" "$output"
  fi

  compression=$(awk -F, -v input="$input" -v command="$command" -v options="$options" 'BEGIN{if(options)command=command" "options}$3==input{command=$4" "command}END{print command}' output.txt)

  timer="$(mktemp)"
  trap "rm -f $timer" EXIT HUP INT QUIT TERM
  one "$timer" "$compression" &

  start=$(date +%s%N)
  eval "$command $options $arguments" 1>stdout.txt 2>stderr.txt
  stop=$(date +%s%N)

  two "$timer"

  if ! identify "${output}[0]" >/dev/null 2>&1
  then
    printf '\033[91m%s\n\n\033[0m' "$output error"
    cat stdout.txt stderr.txt
    return
  fi

  byte=$(wc -c < "$image")
  size=$(wc -c < "$output")
  saving=$(awk -v size="$size" -v byte="$byte" 'BEGIN{print (1-size/byte)*100}')
  time=$(awk -F, -v input="$input" -v start="$start" -v stop="$stop" 'BEGIN{time=(stop-start)/1000000000}$3==input{time+=$8}END{print time}' output.txt)

  sim "$image" "$output"

  printf '%s\n' "$image,$format,$output,$compression,$number,$size,$saving,$time,$line" >> output.txt
  printf '%s\n' "$output" >> out.txt
}


# http://www.theunixschool.com/2012/05/shell-read-text-or-csv-file-and-extract.html
# https://stackoverflow.com/questions/415677/how-to-replace-placeholders-in-a-text-file
# http://tldp.org/LDP/abs/html/ivr.html
# http://ahmed.amayem.com/bash-indirect-expansion-exploration/
# https://stackoverflow.com/questions/399078/what-special-characters-must-be-escaped-in-regular-expressions
# https://stackoverflow.com/questions/15316569/linux-print-all-lines-in-a-file-not-starting-with
# https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
# https://stackoverflow.com/questions/2829613/how-do-you-tell-if-a-string-contains-another-string-in-posix-sh
# https://unix.stackexchange.com/questions/104881/remove-particular-characters-from-a-variable-using-bash
# https://pubs.opengroup.org/onlinepubs/9699919799/utilities/tr.html

while IFS=, read -r image name format size dimensions type colorspace colors depth compression entropy
do
  tick

  touch output.txt

  printf "image: %s\nname: %s\nformat: %s\nsize: %s\ndimensions: %s\ntype: %s\ncolorspace: %s\ncolors: %s\ndepth: %s\ncompression: %s\nentropy: %s\n" "$image" "$name" "$format" "$size" "$dimensions" "$type" "$colorspace" "$colors" "$depth" "$compression" "$entropy"
  echo

  printf '%s\n' "$image" > in.txt

  case $format in
    GIF) commands="gif.txt" ;;
    JPEG) commands="jpg.txt" ;;
    PNG) commands="png.txt" ;;
    SVG) commands="svg.txt" ;;
  esac

  i=1
  while [ $i -le $iterations ]
  do
    touch out.txt

    while read -r input
    do
      while IFS=, read -r command options arguments
      do
        if printf '%s' "$arguments" | grep -qw input
        then
          copy=0
        else
          copy=1
        fi

        output="${input%.*}_$(printf '%s' "$command $options" | tr -cd '[:alnum:]').${input##*.}"

        start "$i" "$image" "$format" "$command" "$options" "$arguments" "$input" "$output" "$copy"
      done < "$commands"
    done < in.txt

    mv out.txt in.txt

    i=$((i + 1))
  done

  score "$image" | separate | column -s, -t | colorize
  echo

  tock
  echo
done < input.txt


formats=$(awk -F',' 'FNR==NR{a[$2]++;next}END{for(i in a)print i}' output.txt)

for f in $formats
do
  total | separate | column -s, -t | colorize
  echo
  total | column -s, -t >> result.txt
  echo >> result.txt
done


while IFS=, read -r image name format size dimensions type colorspace colors depth compression entropy
do
  printf "image: %s\nname: %s\nformat: %s\nsize: %s\ndimensions: %s\ntype: %s\ncolorspace: %s\ncolors: %s\ndepth: %s\ncompression: %s\nentropy: %s\n" "$image" "$name" "$format" "$size" "$dimensions" "$type" "$colorspace" "$colors" "$depth" "$compression" "$entropy" >> result.txt
  echo >> result.txt
  score "$image" | column -s, -t >> result.txt
  echo >> result.txt
done < input.txt



