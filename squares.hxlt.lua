return{

    {inst = "push", args = 1},
    {inst = "push", args = 1},
    {inst = "setvar", args = {"squares", {
        {inst = "stdupe", args = 1},
        {inst = "popvar", args = "y"},
        {inst = "popvar", args = "x"},
        {inst = "varcopy", args = "y"},
        {inst = "varcopy", args = "x"},
        {inst = "add"},
        {inst = "stdupe", args = 1},
        {inst = "print"},
        {inst = "delvar", args = "y"},
        {inst = "delvar", args = "x"},
    }}},
    {inst = "loopfor", args = {"i", 1, 10, 1, {
        {inst = "proccall", args = "squares"},
    }}},

}