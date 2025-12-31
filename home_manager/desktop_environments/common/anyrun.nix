{
  cmd = {
    launch = "anyrun";
    toggle = "pkill anyrun || anyrun";
  };

  module = { pkgs, ... }: {
    programs.anyrun = {
      enable = true;
      package = pkgs.anyrun;
      config = {
        plugins = [
          "${pkgs.anyrun}/lib/libapplications.so"
          "${pkgs.anyrun}/lib/libdictionary.so"
          "${pkgs.anyrun}/lib/librink.so"
          "${pkgs.anyrun}/lib/libshell.so"
          "${pkgs.anyrun}/lib/libsymbols.so"
          "${pkgs.anyrun}/lib/libstdin.so"
          "${pkgs.anyrun}/lib/libtranslate.so"
          "${pkgs.anyrun}/lib/libwebsearch.so"
        ];

        height.fraction = 0.3;
        width.fraction = 0.8;

        x.fraction = 0.5;
        y.fraction = 0.5;

        closeOnClick = true;
        showResultsImmediately = true;
        ignoreExclusiveZones = false;
        layer = "overlay";
      };

      extraCss = ''
        window {
          background: transparent;
        }

        box.main {
          padding: 5px;
          margin: 10px;
          border-radius: 10px;
          border: 2px solid #b7bdf8;
          background-color: #24273a;
          box-shadow: 0 0 5px #181926;
        }

        entry {
          background-color: #363a4f;
          border: 1px solid #5b6078;
          border-radius: 5px;
          padding: 8px;
          margin-bottom: 8px;
          color: #cad3f5;
          caret-color: #b7bdf8;
        }

        entry:focus {
          border: 1px solid #b7bdf8;
        }

        list.plugin {
          background-color: rgba(0, 0, 0, 0);
          min-height: 100%;
        }

        scrolledwindow {
          min-height: 100%;
        }

        row.match {
          padding: 8px;
          margin: 2px 0;
        }

        label.match {
          color: #cad3f5;
        }

        label.match.description {
          font-size: 10px;
          color: #a5adcb;
        }

        .match {
          background: transparent;
          color: #cad3f5;
        }

        .match:selected {
          border-left: 4px solid #b7bdf8;
          background: #363a4f;
          border-radius: 5px;
          animation: fade 0.1s ease-in-out;
        }

        @keyframes fade {
          0% {
            opacity: 0;
          }

          100% {
            opacity: 1;
          }
        }
      '';
    };
  };
}
