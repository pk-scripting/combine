Config = {
    Combinations = {
        ['bananakush_seed'] = { -- Item A
            needs = 'joint_paper', -- Item B
            result = {
                [1] = {name = 'bananakush_joint', amount = 1},
            }, 
            removeItemA = true,
            removeItemB = true,
        },
    }
}