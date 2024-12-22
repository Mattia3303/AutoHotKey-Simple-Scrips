; Class to track the state
class StateManager {
    state := 0

    ; Reset the state
    resetState() {
        this.state := 0
    }

    /**
     * @returns 1 if is active, 0 otherwise
     */
    isStateActive(){
        return this.state
    }
    

    ; Set the state to active
    setActiveState() {
        this.state := 1
    }
}

; Create an instance of the StateManager class
global manager := StateManager()

; First shortcut: Ctrl + A
^A::
{
    manager.setActiveState() ; Set the state to active

    SetTimer ResetState, -2000 ; Schedule the resetState function
    return
}

; Timer function to reset the state
ResetState(){
    manager.resetState()
    return    
}

