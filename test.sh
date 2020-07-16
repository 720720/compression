#!/bin/sh

set -eu


# iterations

iterations=2


# test="butteraugli,ssimulacra,ssim,dssim,psnr,mae,fuzz,ncc"

test="ssim"


# compression

cat > test.txt <<'EOF'

  advdef,-z1,input
  advdef,-z2,input
  advdef,-z3,input
advdef,-z4,input

  advpng,-z1,input
  advpng,-z2,input
  advpng,-z3,input
  advpng,-z4,input

  ect,,input
  ect,-1 -s,input
  ect,-2 -s,input
  ect,-3 -s,input
  ect,-4 -s,input
  ect,-5 -s,input
  ect,-6 -s,input
  ect,-7 -s,input
  ect,-8 -s,input
  ect,-9 -s,input

  optipng,,input
  optipng,-o1,input
  optipng,-o2,input
  optipng,-o3,input
  optipng,-o4,input
  optipng,-o5,input
  optipng,-o6,input
optipng,-o7,input

  oxipng,,input
  oxipng,-o1,input
  oxipng,-o2,input
  oxipng,-o3,input
  oxipng,-o4,input
  oxipng,-o5,input
  oxipng,-o6,input
  oxipng,-o6 -Z,input

pingo,-s1,input
  pingo,-s2,input
  pingo,-s3,input
  pingo,-s4,input
  pingo,-s5,input
  pingo,-s6,input
  pingo,-s7,input
  pingo,-s8,input

  pngoptimizercl,,input

  pngout,,input output

  pngquant,,input

  pngwolf,--verbose-summary --strip-optional,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --estimator=libdeflate,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --estimator=zlib,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --estimator=zopfli,--in=input --out=output

  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=1,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=10,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=100,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=1000,--in=input --out=output

  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=0 --max-evaluations=1,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=0 --max-evaluations=10,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=0 --max-evaluations=100,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=0 --max-evaluations=1000,--in=input --out=output

  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=0 --max-evaluations=1 --estimator=zopfli,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=0 --max-evaluations=10 --estimator=zopfli,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=0 --max-evaluations=100 --estimator=zopfli,--in=input --out=output
  pngwolf,--verbose-summary --strip-optional --max-stagnate-time=0 --max-evaluations=1000 --estimator=zopfli,--in=input --out=output

  truepng,,input
  truepng,-o4,input

  zopflipng,,input output
  zopflipng,-m,input output
  zopflipng,--iterations=10,input output
  zopflipng,--iterations=100,input output
  zopflipng,--iterations=1000,input output

EOF


# https://stackoverflow.com/questions/16414410/delete-empty-lines-using-sed
# https://stackoverflow.com/questions/8206280/delete-all-lines-beginning-with-a-from-a-file
# https://stackoverflow.com/questions/4286469/how-to-parse-a-csv-file-in-bash

mv test.txt tmp.txt

sed -i '/^\s*$/d' tmp.txt
sed -i '/^ /d' tmp.txt

while IFS=, read -r compressor options arguments
do
  if command -v "$compressor" >/dev/null 2>&1
  then
    printf '%s,%s,%s\n' "$compressor" "$options" "$arguments" >> test.txt
  else
    printf '%s\n' "$compressor not available"
  fi
done < tmp.txt

rm tmp.txt


# https://en.wikipedia.org/wiki/Standard_test_image

# wget "http://www.cs.cmu.edu/~chuck/lennapg/lena_std.tif"

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

# wget "https://imgs.xkcd.com/comics/schrodinger.jpg"
# wget "https://imgs.xkcd.com/comics/random_number.png"
# wget "https://imgs.xkcd.com/comics/good_code.png"
# wget "https://imgs.xkcd.com/comics/standards.png"
# wget "https://imgs.xkcd.com/comics/password_strength.png"
# wget "https://imgs.xkcd.com/comics/star_ratings.png"

# wget "http://s3.amazonaws.com/theoatmeal-img/comics/definitely/definitely.png"
# wget "http://s3.amazonaws.com/theoatmeal-img/comics/cats_schrodinger/cats_schrodinger.png"

# wget "https://assets.toggl.com/images/toggl-how-to-save-the-princess-in-8-programming-languages.jpg"
# wget "https://24t9d72kcs873my15o9hr1pu-wpengine.netdna-ssl.com/wp-content/uploads/2017/04/toggl-how-to-kill-the-dragon-with-9-programming-languages.jpg"
# wget "https://24t9d72kcs873my15o9hr1pu-wpengine.netdna-ssl.com/wp-content/uploads/2018/01/toggl-how-to-create-horse-with-programming.jpg"

# wget "https://upload.wikimedia.org/wikipedia/commons/6/6a/Mona_Lisa.jpg"
# wget "https://upload.wikimedia.org/wikipedia/commons/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg"


# https://www.unix.com/shell-programming-and-scripting/176837-bash-hide-terminal-cursor.html

tput civis


# https://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
# https://stackoverflow.com/questions/12314451/accessing-bash-command-line-args-vs
# https://unix.stackexchange.com/questions/314032/how-to-use-arguments-like-1-2-in-a-for-loop

include() {
  for command
  do
    if ! command -v "$command" >/dev/null 2>&1
    then
      echo "$command not available"
      exit 1
    fi
  done
}


# https://en.wikipedia.org/wiki/JPEG

# include guetzli
# guetzli_href="https://github.com/google/guetzli"
# guetzli_version="cb5e4a8"

# include jpeg-recompress
# jpegrecompress_href="https://github.com/danielgtaylor/jpeg-archive"
# jpegrecompress_version="$(jpeg-recompress -V)"

# include jpegoptim
# jpegoptim_href="https://github.com/tjko/jpegoptim"
# jpegoptim_version="$(jpegoptim -V | awk 'NR==1{print substr($2,2)}')"

# include jpegtran
# jpegtran_href="http://jpegclub.org/jpegtran/"
# jpegtran_version="$(jpegtran -version 2>&1 | awk '{print $3}')"

# include mozjpeg-cjpeg
# mozjpeg_href="https://github.com/mozilla/mozjpeg"
# mozjpeg_version="$(mozjpeg-cjpeg -version 2>&1 | awk '{print $3}')"


# https://en.wikipedia.org/wiki/Portable_Network_Graphics

# include advdef
# advdef_href="https://github.com/amadvance/advancecomp"
# advdef_version="$(advdef -V | awk '{print substr($2,2)}')"

# include advpng
# advpng_href="https://github.com/amadvance/advancecomp"
# advpng_version="$(advpng -V | awk '{print substr($2,2)}')"

# include ect
# ect_href="https://github.com/fhanau/Efficient-Compression-Tool"
# ect_version="$(ect | awk '/Version/{print $2}')"

# include optipng
# optipng_href="http://optipng.sourceforge.net/"
# optipng_version="$(optipng -V | awk '/OptiPNG version/{print $3}')"

# include oxipng
# oxipng_href="https://github.com/shssoichiro/oxipng"
# oxipng_version="$(oxipng -V | awk '{print $2}')"

# include pingo
# pingo_href="https://css-ig.net/pingo"
# pingo_version="$(pingo -V | awk '/pingo v/{print substr($2,2)}')"

# include pngcrush
# pngcrush_href="https://pmt.sourceforge.io/pngcrush/"
# pngcrush_version="$(pngcrush -version 2>&1 | awk -F, '/pngcrush/{print $1}' | awk -F' ' '{print $2}')"

# include pngoptimizercl
# pngoptimizercl_href="https://github.com/hadrien-psydk/pngoptimizer"
# pngoptimizercl_version="$(pngoptimizercl | awk 'NR==1{print $2}')"

# include pngout
# pngout_href="http://www.jonof.id.au/kenutils"
# pngout_version="20150319"

# include pngquant
# pngquant_href="https://github.com/kornelski/pngquant"
# pngquant_version="$(pngquant -V | awk '{print $1}')"

# include pngwolf
# pngwolf_href="https://github.com/jibsen/pngwolf-zopfli"
# pngwolf_version="$(pngwolf --version | awk 'NR==1{print $2}')"

# include truepng
# truepng_href="http://x128.ho.ua/pngutils.html"
# truepng_version="$(truepng | awk 'NR==1 {print $2}')"

# include zopflipng
# zopflipng_href="https://github.com/google/zopfli"
# zopflipng_version="64c6f36"


# https://en.wikipedia.org/wiki/Structural_similarity

# include butteraugli
# butteraugli_href="https://github.com/google/butteraugli"
# butteraugli_version="856a4da"

# include compare
# compare_href="https://www.imagemagick.org/script/compare.php"
# compare_version="$(compare -version | awk 'NR==1 {print $3}')"

# include ssimulacra
# ssimulacra_href="https://github.com/cloudinary/ssimulacra"
# ssimulacra_version="2a830ab"


# http://netpbm.sourceforge.net/doc/directory.html

for file in *.jpg
do
  if [ -f "$file" ]
  then
    name="$(basename "$file" .jpg)"
    jpegtopnm "$file" > "${name}.ppm"
  fi
done

for file in *.tif
do
  if [ -f "$file" ]
  then
    name="$(basename "$file" .tif)"
    tifftopnm "$file" > "${name}.ppm"
  fi
done

for file in *.ppm
do
  if [ -f "$file" ]
  then
    name="$(basename "$file" .ppm)"
    pnmtopng -compression=0 "$file" > "${name}.png"
  fi
done


# https://stackoverflow.com/questions/6363441/check-if-a-file-exists-with-wildcard-in-shell-script

if ! ls ./*.png >/dev/null 2>&1
then
  echo "no images found"
  exit 1
fi


# https://unix.stackexchange.com/questions/40786/how-to-do-integer-float-calculations-in-bash-or-other-languages-frameworks
# https://stackoverflow.com/questions/38595559/how-to-define-a-function-on-one-line

calc() { awk "BEGIN{print $*}"; }


# https://unix.stackexchange.com/questions/162619/to-print-execution-time-of-script-from-script
# https://stackoverflow.com/questions/16959337/usr-bin-time-format-output-elapsed-time-in-milliseconds

tick() { tick=$(date +%s%N); }
tock() { awk "BEGIN{print ($(date +%s%N)-$tick)/1000000000}"; }


# https://stackoverflow.com/questions/16896369/show-elapsed-time-every-second-running-a-bash-script
# https://stackoverflow.com/questions/5861428/bash-script-erase-previous-line

starttimer() {
  s=0
  while [ -e "$1" ]
  do
    printf '%s %ss\033[0K\r' "$2" "$s"
    sleep 1
    s=$((s + 1))
  done
}

stoptimer() {
  rm -f "$1"
}


# https://unix.stackexchange.com/questions/102008/how-do-i-trim-leading-and-trailing-whitespace-from-each-line-of-some-output
# https://stackoverflow.com/questions/20262869/why-does-1-in-awk-print-the-current-line
# https://unix.stackexchange.com/questions/118433/quoting-within-command-substitution-in-bash
# https://www.tecmint.com/empty-delete-file-content-linux/
# https://www.regular-expressions.info/wordboundaries.html
# https://stackoverflow.com/questions/30224018/imagemagick-compare-exit-code-1-when-spawned-from-node-js-but-exit-code-0-when

start() {
  number="$1"
  image="$2"
  compressor="$3"
  options="$4"
  command="$5"
  input="$6"
  output="$7"
  copy="$8"

  if grep -q ",$output," output.txt
  then
    echo "$output" >> out.txt
    return
  fi

  if grep -q ",$input,.*$compressor" output.txt
  then
    return
  fi

  if [ "$copy" -eq 1 ]
  then
    cp "$input" "$output"
  fi

  compressor="$(awk -F, -v input="$input" -v compressor="$compressor" -v options="$options" 'BEGIN{if(options)compressor=compressor" "options}$2==input{compressor=$3" "compressor}END{print compressor}' output.txt)"

  timer="$(mktemp)"
  starttimer "$timer" "$compressor" &

  start=$(date +%s%N)
  eval "$command" 1>stdout.txt 2>stderr.txt
  stop=$(date +%s%N)

  stoptimer "$timer"

  if ! identify "$output" >/dev/null 2>&1
  then
    cat stdout.txt stderr.txt
    return
  fi

  byte=$(wc -c < "$image")
  size=$(wc -c < "$output")
  saving=$(awk -v size="$size" -v byte="$byte" 'BEGIN{print (1-size/byte)*100}')
  time=$(awk -F, -v input="$input" -v start="$start" -v stop="$stop" 'BEGIN{time=(stop-start)/1000000000}$2==input{time+=$7}END{print time}' output.txt)
  genomes=$(awk 'BEGIN{genomes=0}/number of genomes/{genomes+=$5}END{print genomes}' stdout.txt)


  delta="$test"

  if echo "$test" | grep -qw butteraugli
  then
    butteraugli="$(butteraugli "$image" "$output")"
    delta="$(echo "$delta" | sed "s/\<butteraugli\>/$butteraugli/")"
  fi

  if echo "$delta" | grep -qw ssimulacra
  then
    ssimulacra="$(ssimulacra "$image" "$output")"
    delta="$(echo "$delta" | sed "s/\<ssimulacra\>/$ssimulacra/")"
  fi

  if echo "$delta" | grep -qw ssim
  then
    ssim="$(compare -metric ssim "$image" "$output" null: 2>&1 || true)"
    delta="$(echo "$delta" | sed "s/\<ssim\>/$ssim/")"
  fi

  if echo "$delta" | grep -qw dssim
  then
    dssim="$(compare -metric dssim "$image" "$output" null: 2>&1 || true)"
    delta="$(echo "$delta" | sed "s/\<dssim\>/$dssim/")"
  fi

  if echo "$delta" | grep -qw psnr
  then
    psnr="$(compare -metric psnr "$image" "$output" null: 2>&1 || true)"
    delta="$(echo "$delta" | sed "s/\<psnr\>/$psnr/")"
  fi

  if echo "$delta" | grep -qw mae
  then
    mae="$(compare -metric mae "$image" "$output" null: 2>&1 || true)"
    delta="$(echo "$delta" | sed "s/\<mae\>/$mae/")"
  fi

  if echo "$delta" | grep -qw fuzz
  then
    fuzz="$(compare -metric fuzz "$image" "$output" null: 2>&1 || true)"
    delta="$(echo "$delta" | sed "s/\<fuzz\>/$fuzz/")"
  fi

  if echo "$delta" | grep -qw ncc
  then
    ncc="$(compare -metric ncc "$image" "$output" null: 2>&1 || true)"
    delta="$(echo "$delta" | sed "s/\<ncc\>/$ncc/")"
  fi


  echo "$image,$output,$compressor,$number,$size,$saving,$time,$genomes,$delta" >> output.txt
  echo "$output" >> out.txt
  echo "$output" >> files.txt
}


# https://unix.stackexchange.com/questions/318755/shell-customize-the-color-of-each-line-of-a-log-file-based-on-a-pattern
# https://unix.stackexchange.com/questions/340091/why-the-output-of-column-is-misaligned-with-a-ansi-colored-input
# https://stackoverflow.com/questions/11454343/pipe-output-to-bash-function
# https://stackoverflow.com/questions/34497884/writing-a-shell-function-that-accepts-input-from-a-pipe-and-arguments-simultaneo

# https://github.com/seebi/dircolors-solarized
# https://en.wikipedia.org/wiki/ANSI_escape_code
# http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html


separate() {
  awk -v FS="," -v OFS=",\x1F" '{for(i=1;i<NF;i++)printf "%s%s",$i,OFS;print $NF}'
}


colorize() {
  awk -v FS="\x1F" '
  function color(c,s) {printf("\033[38;5;%dm%s\033[0m\n",c,s);next;}
  NR==1{color(33,$0)}
  $2==1{color(255,$0)}
  $2==2{color(245,$0)}
  $2==3{color(240,$0)}
  {color(240,$0)}
  '
}

newline() {
  echo
}


# https://askubuntu.com/questions/830776/remove-file-but-exclude-all-files-in-a-list
# https://mywiki.wooledge.org/ParsingLs

# stdout.txt
# stderr.txt
# input.txt
# output.txt
# in.txt
# out.txt
# files.txt
# test.txt
# result.txt

clean() {
  for file in *
  do
    if ! grep -qxFe "$file" files.txt
    then
      rm -f "$file"
    fi
  done
}


# https://stackoverflow.com/questions/39319539/what-is-the-most-portable-way-to-write-an-iteration-for-while-loop-in-a-posi

if [ ! -f input.txt ]
then
  echo "test.sh" > files.txt
  echo "test.txt" >> files.txt
  echo "result.txt" >> files.txt
  echo "files.txt" >> files.txt
  echo "input.txt" >> files.txt
  echo "output.txt" >> files.txt

  for file in *.png
  do
    image="$(identify -format "%f" "$file")"
    name="$(identify -format "%t" "$file")"
    format="$(identify -format "%m" "$file")"
    size="$(wc -c < "$file")"
    dimensions="$(identify -format "%G" "$file")"
    type="$(identify -format "%[type]" "$file")"
    colorspace="$(identify -format "%[colorspace]" "$file")"
    colors="$(identify -format "%k" "$file")"
    depth="$(identify -format "%z-bit" "$file")"
    compression="$(identify -format "%C" "$file")"
    entropy="$(identify -format "%[entropy]" "$file")"

    echo "$image,$name,$format,$size,$dimensions,$type,$colorspace,$colors,$depth,$compression,$entropy" >> input.txt
    echo "$image" >> files.txt
  done
fi


clean
newline


# http://www.theunixschool.com/2012/05/shell-read-text-or-csv-file-and-extract.html

# https://stackoverflow.com/questions/415677/how-to-replace-placeholders-in-a-text-file
# http://tldp.org/LDP/abs/html/ivr.html
# http://ahmed.amayem.com/bash-indirect-expansion-exploration/
# https://stackoverflow.com/questions/399078/what-special-characters-must-be-escaped-in-regular-expressions
# https://stackoverflow.com/questions/15316569/linux-print-all-lines-in-a-file-not-starting-with

while IFS=, read -r image name format size dimensions type colorspace colors depth compression entropy
do
  tick

  touch output.txt

  printf "image: %s\nname: %s\nformat: %s\nsize: %s\ndimensions: %s\ntype: %s\ncolorspace: %s\ncolors: %s\ndepth: %s\ncompression: %s\nentropy: %s\n" "$image" "$name" "$format" "$size" "$dimensions" "$type" "$colorspace" "$colors" "$depth" "$compression" "$entropy"
  newline

  echo "$image" > in.txt

  i=1
  while [ $i -le $iterations ]
  do
    touch out.txt

    while read -r input
    do
      while IFS=, read -r compressor options arguments
      do
        if echo "$arguments" | grep -qw input && echo "$arguments" | grep -qw output
        then
          copy=0
        else
          copy=1
        fi

        output="$(basename "$input" .png)_$(echo "$compressor $options" | tr -d '[ \-=] ').png"
        arguments="$(echo "$arguments" | sed "s/input/$input/" | sed "s/output/$output/")"
        command="$compressor $options $arguments"

        start "$i" "$image" "$compressor" "$options" "$command" "$input" "$output" "$copy"
      done < test.txt
    done < in.txt

    mv out.txt in.txt

    i=$((i + 1))
  done

  awk -v FS="," -v OFS="," -v test="$test" -v image="$image" 'BEGIN{print "compressor","number","size","saving","time","genomes",test}$1==image{for(i=3;i<NF;i++)printf "%s%s",$i,OFS;print $NF}' output.txt | awk 'NR==1;NR>1{print|"sort -t, -k4gr -k2g -k5g"}' | separate | column -s, -t | colorize
  newline

  tock
  newline
done < input.txt

awk -v FS="," -v OFS="," '{number[$3]=$4;processed[$3]++;if($6>0){compressed[$3]++};size[$3]+=$5;saving[$3]+=$6;time[$3]+=$7;genomes[$3]+=$8;}END{print "compressor,number,processed,compressed,size,saving,time,genomes";for(i in processed)print i,number[i],processed[i]+0,compressed[i]+0,size[i],saving[i]/processed[i],time[i],genomes[i]|"sort -t, -k6gr -k4g -k7g"}' output.txt | separate | column -s, -t | colorize
awk -v FS="," -v OFS="," '{number[$3]=$4;processed[$3]++;if($6>0){compressed[$3]++};size[$3]+=$5;saving[$3]+=$6;time[$3]+=$7;genomes[$3]+=$8;}END{print "compressor,number,processed,compressed,size,saving,time,genomes";for(i in processed)print i,number[i],processed[i]+0,compressed[i]+0,size[i],saving[i]/processed[i],time[i],genomes[i]|"sort -t, -k6gr -k4g -k7g"}' output.txt | column -s, -t > result.txt
newline >> result.txt

while IFS=, read -r image name format size dimensions type colorspace colors depth compression entropy
do
  printf "image: %s\nname: %s\nformat: %s\nsize: %s\ndimensions: %s\ntype: %s\ncolorspace: %s\ncolors: %s\ndepth: %s\ncompression: %s\nentropy: %s\n" "$image" "$name" "$format" "$size" "$dimensions" "$type" "$colorspace" "$colors" "$depth" "$compression" "$entropy" >> result.txt
  newline >> result.txt
  awk -v FS="," -v OFS="," -v test="$test" -v image="$image" 'BEGIN{print "compressor","number","size","saving","time","genomes",test}$1==image{for(i=3;i<NF;i++)printf "%s%s",$i,OFS;print $NF}' output.txt | awk 'NR==1;NR>1{print|"sort -t, -k4gr -k2g -k5g"}' | column -s, -t >> result.txt
  newline >> result.txt
done < input.txt


clean
newline


# https://www.unix.com/shell-programming-and-scripting/176837-bash-hide-terminal-cursor.html

tput cnorm

