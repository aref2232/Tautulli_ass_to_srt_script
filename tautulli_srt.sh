#!/bin/sh

log_file="./script_log.txt"

log() {
    echo "$(date) - $1" >> "$log_file"
}

log "script started"
ffmpeg_path="./ffmpeg-6.1-amd64-static/ffmpeg"
ffprobe_path="./ffmpeg-6.1-amd64-static/ffprobe"
path="$1"

# Get the number of subtitle streams in the file
sub_count=$($ffprobe_path -loglevel error -select_streams s -show_entries stream=codec_name -of csv=p=0 "$path" | wc -l)

# If no subtitles are found, exit the script
if [ $sub_count -eq 0 ]; then
    log "No subtitles found in $path."
    exit 1  # or another appropriate exit code
fi

# Loop through each subtitle stream and extract it as an srt file
for i in $(seq 0 $((sub_count-1))); do
    # Get the original language code of the subtitle stream
    original_lang=$($ffprobe_path -loglevel error -select_streams s:$i -show_entries stream_tags=language -of csv=p=0 "$path")

    # Translate "eng" to "en" (or any other language code adjustments you need)
    case "$original_lang" in
        eng)
            sub_lang="en"
            ;;
        *)
            sub_lang="$original_lang"
            ;;
    esac

    # Set the output file name with the language code as a suffix in the same folder as the original file
    output_file="$(dirname "$path")/$(basename "$path" .mkv).${sub_lang}.srt"

    # Check if the subtitle file already exists; if yes, skip this iteration
    if [ -e "$output_file" ]; then
        log "Subtitle file $output_file already exists. Skipping extraction for language code: $sub_lang"
        continue
    fi

    # Extract the subtitle stream using ffmpeg
    $ffmpeg_path -i "$path" -map 0:s:$i "$output_file"

    # Print a message indicating the output file name and path
    log "Subtitle extracted to $output_file"
done

# Closing Section
log "script completed"

