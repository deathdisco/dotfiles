{ pkgs, ... }:
{
    home.file.".config/skippy-xd/skippy-xd.rc".text = ''
        [general]
        distance = 30
        useNetWMFullscreen = true
        ignoreSkipTaskbar = true
        updateFreq = 10.0
        lazyTrans = false
        pipePath = /tmp/skippy-xd-fifo
        movePointerOnStart = true
        movePointerOnSelect = true
        movePointerOnRaise = true
        switchDesktopOnActivate = false
        useNameWindowPixmap = false
        forceNameWindowPixmap = false
        includeFrame = true
        allowUpscale = true
        showAllDesktops = false
        showUnmapped = true
        preferredIconSize = 48
        clientDisplayModes = thumbnail icon filled none
        iconFillSpec = orig mid mid #00FFFF
        fillSpec = orig mid mid #FFFFFF
        background =

        [xinerama]
        showAll = true

        [normal]
        tint = black
        tintOpacity = 0
        opacity = 255

        [highlight]
        tint = #101020
        tintOpacity = 3
        opacity = 255

        [tooltip]
        show = true
        followsMouse = true
        offsetX = 20
        offsetY = 20
        align = left
        border = #000000
        background = #000000
        opacity = 128
        text = #ffffff
        textShadow = black
        font = Source Code Pro:size=10

        [bindings]
        miwMouse1 = focus
        miwMouse2 = close-ewmh
        miwMouse3 = iconify
    '';

    home.packages = with pkgs; [
        skippy-xd
    ];
}
