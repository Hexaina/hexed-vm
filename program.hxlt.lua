return{

    {inst = "setvar", args = {"acc", 0}},
    {inst = "push", args = true},
    {inst = "push", args = {
        {inst = "stwhile", args = {
            {inst = "varcopy", args = "acc"},
            {inst = "push", args = 1},
            {inst = "add"},
            {inst = "popvar", args = "acc"},
            {inst = "varcopy", args = "acc"},
            {inst = "print"},
            {inst = "threadpause"}
        }},
    }},
    {inst = "stnewthread", args = "co"},

    {inst = "threadresume", args = "co"},
    {inst = "threadresume", args = "co"},
    {inst = "threadresume", args = "co"},
    {inst = "threadresume", args = "co"},
    {inst = "threadresume", args = "co"},

}