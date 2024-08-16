#Requires AutoHotkey v2.0

; Instantly moves the cursor to the center of the screen
CenterMouse() {
    MouseMove(A_ScreenWidth // 2, A_ScreenHeight // 2, 0)
}

ReturnToInitialPosition(coords) {
    MouseMove(coords.x, coords.y, 2)
}

; Returns current mouse position
GetMousePosition() {
    x := 0
    y := 0

    MouseGetPos(&x, &y)

    return {x: x, y: y}
}

; Slowly moves the mouse
SlowMouseMove(DistanceX, DistanceY)
{
    Steps := 10
    Delay := 1

    MouseGetPos(&StartX, &StartY)

    ; Calculate step sizes
    StepX := DistanceX // Steps
    StepY := DistanceY // Steps

    ; Perform the movement in small steps
    Loop Steps
    {
        ; Calculate the new position
        NewX := StartX + (StepX * A_Index)
        NewY := StartY + (StepY * A_Index)

        ; Move the mouse to the new position
        MouseMove(NewX, NewY, 0)

        ; Introduce a delay
        Sleep Delay
    }
}

; Orchestrate everything to change map
ChangeMap(x, y) {
    If WinActive("Dofus") {
        initialPositionCoords := GetMousePosition()
        CenterMouse()
        Click("down")
        SlowMouseMove(x, y) 
        Click("up")
        ReturnToInitialPosition(initialPositionCoords)
    } else {
        ; Sends the regular command if not in Dofus
        send "{" A_ThisHotkey "}"
    }
}

Left::
    {
        ChangeMap(200, 0)

    }

Right::
    {
        ChangeMap(-200, 0)
    }

Up::
    {
        ChangeMap(0, 200)
    }

Down::
    {
        ChangeMap(0, -200)
    }

