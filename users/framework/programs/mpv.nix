# TODO: Set this up:
# https://www.linuxuprising.com/2021/07/open-youtube-and-more-videos-from-your.html
{ config, lib, pkgs, ... }: {
  programs.mpv.enable = true;

  programs.mpv.config = {
    # Read https://mpv.io/manual/stable/#options-hwdec before enabling.
    # hwdec = "auto-safe";

    # Prevent harmless warnings/errors when using hardware decoding
    msg-level = "vo=fatal";

    # https://github.com/mpv-player/mpv/issues/4241
    # Pick the best format it can find (up to but not above 720p), chose
    # 60fps or lower, and lastly, ignore the VP9 codec.
    ytdl-format =
      "bestvideo[height<=?720][fps<=?60][vcodec!=?vp9]+bestaudio/best";
  };
}
