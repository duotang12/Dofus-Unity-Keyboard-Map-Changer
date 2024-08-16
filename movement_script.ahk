#Requires AutoHotkey v2.0

; Instantly moves the cursor to the center of the screen
centerMouse() {
    MouseMove(A_ScreenWidth // 2, A_ScreenHeight // 2, 0)
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
changeMap(x, y) {
    If WinActive("Dofus") {
        centerMouse()
        Click("down")
        SlowMouseMove(x, y) 
        Click("up")
    } else {
        ; Sends the regular command if not in Dofus
        send "{" A_ThisHotkey "}"
    }
}

Left::
    {
        changeMap(200, 0)

    }

Right::
    {
        changeMap(-200, 0)
    }

Up::
    {
        changeMap(0, 200)
    }

Down::
    {
        changeMap(0, -200)
    }

