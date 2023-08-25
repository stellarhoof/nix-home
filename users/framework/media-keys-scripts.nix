{ pkgs, ... }:
let
  brightness-notify = pkgs.writeShellApplication {
    name = "brightness-notify.sh";
    runtimeInputs = with pkgs; [ bc dunst brightnessctl ];
    text = ''
      getvalue() {
        echo "$(brightnessctl g) * 100 / $(brightnessctl m)" | bc
      }

      geticon() {
        if [ "$1" -eq 0 ]; then
          echo "notification-display-brightness-off"
        elif [ "$1" -lt 20 ]; then
          echo "notification-display-brightness-low"
        elif [ "$1" -lt 50 ]; then
          echo "notification-display-brightness-medium"
        elif [ "$1" -lt 100 ]; then
          echo "notification-display-brightness-high"
        else
          echo "notification-display-brightness-full"
        fi
      }

      brightnessctl "$@"

      value="$(getvalue)"

      # shellcheck disable=all
      icon="$(geticon $value)"

      dunstify \
        --appname=brightness-notify.sh \
        --urgency=low \
        --timeout=2000 \
        --icon="$icon" \
        --hints=int:value:"$value" \
        --hints=string:x-dunst-stack-tag:brightness-notify.sh \
        "Brightness: $value%"
    '';
  };

  volume-notify = pkgs.writeShellApplication {
    name = "volume-notify.sh";
    runtimeInputs = with pkgs; [
      pulseaudio
      pamixer
      gnugrep
      dunst
      perl
      coreutils
      libcanberra-gtk2
    ];
    text = ''
      getsink() {
        pamixer --get-default-sink | tail -n1 | perl -pe 's/^[[:digit:]]+ ".*?" "(.*)"$/\1/'
      }

      geticon() {
        if [ "$2" == "true" ]; then
          echo "notification-audio-volume-muted"
        elif [ "$1" -eq 0 ]; then
          echo "notification-audio-volume-off"
        elif [ "$1" -lt 20 ]; then
          echo "notification-audio-volume-low"
        elif [ "$1" -lt 50 ]; then
          echo "notification-audio-volume-medium"
        else
          echo "notification-audio-volume-high"
        fi
      }

      pamixer "$@"

      value="$(pamixer --get-volume || true)"

      muted="$(pamixer --get-mute || true)"

      sink="$(getsink)"

      # shellcheck disable=all
      icon="$(geticon $value $muted)"

      dunstify \
        --appname=volume-notify.sh \
        --urgency=low \
        --timeout=2000 \
        --icon="$icon" \
        --hints=int:value:"$value" \
        --hints=string:x-dunst-stack-tag:volume-notify.sh \
        "Volume: $value%" \
        "$sink"
    '';
  };

  battery-notify = pkgs.writeShellApplication {
    name = "battery-notify.sh";
    runtimeInputs = with pkgs; [ dunst ];
    text = ''
      dunstify \
        --appname=battery-notify.sh \
        --urgency=critical \
        "Battery running out!!!"
    '';
  };
in {
  home.file.".local/bin/volume-notify.sh" = {
    executable = true;
    source = "${volume-notify}/bin/volume-notify.sh";
  };

  home.file.".local/bin/brightness-notify.sh" = {
    executable = true;
    source = "${brightness-notify}/bin/brightness-notify.sh";
  };

  home.file.".local/bin/battery-notify.sh" = {
    executable = true;
    source = "${battery-notify}/bin/battery-notify.sh";
  };
}
