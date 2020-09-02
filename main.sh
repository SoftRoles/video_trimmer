rm parts.txt
rm parts/*.mp4
touch parts.txt
filename=$1
echo "${filename%.*}"
set trim_len = 0
set counter = 0
while IFS=" " read -r start stop ddee remainder; do
    # echo $start
    # echo $stop
    # start="$(printf '%d' $start 2>/dev/null)"
    # stop="$(printf '%d' $stop 2>/dev/null)"
    # start=$(( start - trim_len ))
    # stop=$(( stop - trim_len ))
    # echo $start
    # echo $stop
    # trim_len=$((trim_len + stop - start))
    counter=$((counter + 1))
    # ffmpeg -ss "$start" -i "$filename" -to "$stop" -c copy "$counter.mp4"
    ffmpeg -y -t "$stop" -i "$filename" -ss "$start" -async 1 "parts/$counter.mp4" -loglevel error
    # echo "ffmpeg -ss "$start" -i $filename" -to "$stop" "$counter.mp4"
    echo "file parts/$counter.mp4" >>parts.txt
    # echo "$filename $start -i $filename"
    # echo $trim_len
done <"intervals.txt"
ffmpeg -y -f concat -i parts.txt -c copy "${filename%.*}-cut.mp4" -loglevel error
