{ config, pkgs, lib, ... }:

let
  settings = (import ../settings.nix);
  colors = settings.colors;

in {
  programs = {
    firefox = {
      enable = true;
      profiles.nom = {
        # path = "$HOME/.config/firefox";
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "general.smoothScroll" = false;
        };
        userChrome = ''

          * {
              font-family: "${settings.fonts.applications.firefox}" !important;
          }

          #navigator-toolbox #nav-bar {
              background: ${colors.black} !important;
              box-shadow: none !important;
          }

          #navigator-toolbox .toolbar-items {
              background: ${colors.ui.background}  !important;
          }

          #navigator-toolbox #urlbar {
              background: ${colors.ui.background} !important;
              color: ${colors.ui.text} !important;
              padding: 0 !important;
              padding-left: 1ch !important;
              font-size: 13px;
              height: 33px;
          }

          #navigator-toolbox #urlbar-background {
              background: ${colors.ui.background} !important;
              border: none !important;
              margin: 0 !important;
          }

          /*
          *  Hide window controls
          */
          .titlebar-buttonbox-container{
              display: none !important;
          }

          .titlebar-placeholder,
            #TabsToolbar .titlebar-spacer { display: none; }
            #navigator-toolbox::after { display: none !important; }


          /*
          *  Hide all the clutter in the navbar
          */
          
          #main-window :-moz-any(#back-button,
                    #forward-button,
                    #stop-reload-button,
                    #home-button,
                    #library-button,
                    #sidebar-button,
                    #star-button,
                    #pocket-button,
                    #permissions-granted-icon,
                    #fxa-toolbar-menu-button,
                    #_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action, /* Vimium */
                    #ublock0_raymondhill_net-browser-action) { display: none !important; }

          /*
          *  Hide tabs if only one tab
          */
          #titlebar .tabbrowser-tab[first-visible-tab="true"][last-visible-tab="true"]{
              display: none !important;
          }

          /*
          *  Minimal theme
          */
          #navigator-toolbox {
              // border-bottom: 1px;
          }

          #navigator-toolbox toolbarspring {
              display: none;
          }

          /* Move tab line to the bottom */
          #navigator-toolbox .tab-line {
              -moz-box-ordinal-group: 2;
          }

          .tab-line[selected=true] {
              background-color: ${ colors.ui.background } !important;
          }

          #navigator-toolbox #urlbar-container {
              padding: 0 !important;
              margin: 0 !important;
          }

          #navigator-toolbox #urlbar {
              border: none !important;
              border-radius: 0 !important;
              box-shadow: none !important;
          }

          #navigator-toolbox #PanelUI-button {
              padding: 0 !important;
              margin: 0 !important;
              border: none !important;
          }

          #navigator-toolbox #pageActionButton {
              display: none;
          }

          #navigator-toolbox #pageActionSeparator {
              display: none;
          }

          #fullscr-toggler {
              height: 0 !important;
          }

          #navigator-toolbox .urlbar-history-dropmarker {
              display: none;
          }

          #navigator-toolbox #tracking-protection-icon-container {
              padding-right: 0 !important;
              border: none !important;
              display: none !important;
          }

          #navigator-toolbox .tab-close-button, #navigator-toolbox #tabs-newtab-button {
              display: none;
          }

          // extension area
          #navigator-toolbox #nav-bar-customization-target {
              background: ${ colors.firefox.background } !important;
          }

          #navigator-toolbox .toolbarbutton-1 {
              width: 22px;
          }

          #navigator-toolbox #downloads-button {
              color: ${ colors.firefox.text } ;
              background: ${ colors.firefox.background } !important;
          }

          #navigator-toolbox #PanelUI-button {
              opacity: 1 !important;
              background: ${ colors.firefox.background } !important;
          }

          #navigator-toolbox #PanelUI-menu-button {
              background: ${ colors.firefox.background } !important;
              color: ${ colors.firefox.menu-icon } !important;
          }

          #navigator-toolbox .tabbrowser-tab {
              font-size: 12px
          }

          #navigator-toolbox .tab-background {
              background: ${ colors.firefox.background } !important;
              box-shadow: none!important;
              border: none !important;
          }

          #navigator-toolbox .tabbrowser-tab .tab-label {
              color: ${ colors.firefox.text } !important;
          }

          #navigator-toolbox .tab-background[selected="true"] {
              background: ${ colors.firefox.selected-tab-background } !important;
          }

          #navigator-toolbox .tabbrowser-tab[selected="true"] .tab-label {
              color: ${ colors.firefox.selected-tab-text } !important;
          }

          #navigator-toolbox .tabbrowser-tab::after {
              display: none !important;
          }

          #navigator-toolbox #urlbar-zoom-button {
              border: none !important;
          }

          #appMenu-fxa-container, #appMenu-fxa-container + toolbarseparator {
              display: none !important;
          }

          #sync-setup {
              display: none !important;
          }

          #PanelUI-button {
              -moz-box-ordinal-group: 0;
              border-left: none !important;
              border-right: none !important;
              position: absolute;
          }

          #toolbar-context-menu .viewCustomizeToolbar {
              display: none !important;
          }

          :root[uidensity=compact] #PanelUI-button {
              margin-top: -28px;
          }

          #PanelUI-button {
              margin-top: -30px;
          }

          :root[uidensity=touch] #PanelUI-button {
              margin-top: -36px;
          }

          /*
          *  Tabs to the right of the urlbar
          */

          /* Modify these to change relative widths or default height */
          #navigator-toolbox{
              --uc-navigationbar-width: 40vw;
              --uc-toolbar-height: 33px;
          }
          /* Override for other densities */
          :root[uidensity="compact"] #navigator-toolbox{ --uc-toolbar-height: 30px; }
          :root[uidensity="touch"] #navigator-toolbox{ --uc-toolbar-height: 30px; }

          :root[uidensity=compact] #urlbar-container.megabar{
              --urlbar-container-height: var(--uc-toolbar-height) !important;
              padding-block: 0 !important;
          }
          :root[uidensity=compact] #urlbar.megabar{
              --urlbar-toolbar-height: var(--uc-toolbar-height) !important;
          }

          /* prevent urlbar overflow on narrow windows */
          /* Dependent on how many items are in navigation toolbar ADJUST AS NEEDED */
          @media screen and (max-width: 1300px){
              #urlbar-container{ min-width:unset !important }
          }

          #TabsToolbar{ margin-left: var(--uc-navigationbar-width); }
          // tabbrowser-tabs{ --tab-min-height: var(--uc-toolbar-height) !important; }

          /* This isn't useful when tabs start in the middle of the window */
          .titlebar-placeholder[type="pre-tabs"],
          .titlebar-spacer[type="pre-tabs"]{ display: none }

          #navigator-toolbox > #nav-bar{
              margin-right:calc(100vw - var(--uc-navigationbar-width));
              margin-top: calc(0px - var(--uc-toolbar-height));
          }

          /* Zero window drag space  */
          :root[tabsintitlebar="true"] #nav-bar{ padding-left: 0px !important; padding-right: 0px !important; }

          /* 1px margin on touch density causes tabs to be too high */
          .tab-close-button{ margin-top: 0 !important }

          /* Hide dropdown placeholder */
          #urlbar-container:not(:hover) .urlbar-history-dropmarker{ margin-inline-start: -28px; }

          /* Fix customization view */
          #customization-panelWrapper > .panel-arrowbox > .panel-arrow{ margin-inline-end: initial !important; }
        '';
      };
      extensions = [ ];
    };
  };
}

# "1password-x-password-manager" = buildFirefoxXpiAddon {
#   pname = "1password-x-password-manager";
#   version = "1.20.0";
#   addonId = "{d634138d-c276-4fc8-924b-40a0ea21d284}";
#   url = "https://addons.mozilla.org/firefox/downloads/file/3597753/1password_x_password_manager-1.20.0-fx.xpi?src=";
#   sha256 = "ec3c46d4c1f4a7a7be8055a7327e207cf037f8ca579af9cd9930499732632569";
#   meta = with stdenv.lib;
#   {
#     homepage = "https://1password.com";
#     description = "The best way to experience 1Password in your browser. Easily sign in to sites, generate passwords, and store secure information, including logins, credit cards, notes, and more.";
#     license = {
#       shortName = "1pwd";
#       fullName = "Service Agreement for 1Password users and customers";
#       url = "https://1password.com/legal/terms-of-service/";
#       free = false;
#       };
#     platforms = platforms.all;
#     };
#   };
