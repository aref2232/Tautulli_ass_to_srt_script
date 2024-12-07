Tautulli Subtitle Extractor Notification Agent

This script automatically extracts subtitle streams from newly added media files and saves them as .srt files. It’s designed to be used as a custom notification agent in Tautulli, triggered whenever a new file is added to your Plex library.
Setup Instructions
1. Download the Repository

Clone or download the repository to your Tautulli server:

git clone https://github.com/yourusername/tautulli-subtitle-extractor.git

Alternatively, download the ZIP file from GitHub and extract it.
2. Place the Folder with the Script and FFmpeg in an Accessible Location

Move the entire folder (which contains both the subtitle_extractor.sh script and the ffmpeg static build) to a location that is accessible to Tautulli. For example:

/path/to/tautulli-subtitle-extractor/

This folder should contain:

    subtitle_extractor.sh (the script)
    ffmpeg-6.1-amd64-static/ (the FFmpeg static build folder)

Make sure that Tautulli has permission to access this folder.
3. Ensure ffmpeg and ffprobe are Available

The script expects the FFmpeg binaries (ffmpeg and ffprobe) to be located in the ffmpeg-6.1-amd64-static/ folder. If the binaries are located elsewhere, you can modify the script to point to the correct paths.
4. Configure the Custom Notification Agent in Tautulli

    Open the Tautulli web interface.

    Go to Settings > Notification Agents.

    Click Add Custom Script.

    In the Name field, give the agent a name, e.g., Subtitle Extractor.

    In the Script Path field, provide the path to the subtitle_extractor.sh script. Example:

/path/to/tautulli-subtitle-extractor/subtitle_extractor.sh

In the Script Arguments field, add the following:

    {file}

    This will pass the file path of the newly added media file to the script.

    Save the notification agent.

5. How It Works

    The script will be triggered by Tautulli whenever a new media file is added to your Plex library.
    The script will use ffprobe to detect subtitle streams and ffmpeg to extract them as .srt files.
    The subtitle files will be saved in the same directory as the video file.
    If subtitle files already exist for a language, the script will skip extraction for that language.

Notes

    Ensure that the Tautulli user has read/write permissions for the media files and can execute the script.
    The script creates a log file (script_log.txt) in the same directory to track its operations.

License

This script is released under the MIT License.
