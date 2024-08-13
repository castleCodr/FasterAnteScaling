--- STEAMODDED HEADER
--- MOD_NAME: Faster Ante Scaling
--- MOD_ID: fastsc
--- MOD_AUTHOR: [CubeCastle]
--- Dependencies: [Talisman]
--- MOD_DESCRIPTION: makes antes scale faster
--- PRIORITY: 1000

----------------------------------------------
------------MOD CODE -------------------------
gba = get_blind_amount
local ante_config = {}
local read_config = SMODS.load_file("config.lua")
if read_config then
    ante_config = read_config()
end
function get_blind_amount(ante)
    local orig_amt = gba(ante)
    if(ante <= 16) then
        return orig_amt
    end
    local extraAntes = ante - 16
    if(orig_amt == nil) then
        orig_amt = to_big(10,308)
    end
    local list = {1.320114182,1.505435985,1.728157537,1.993313858,2.306314769,2.672952465,3.099408871,3.592262799,4.158496911,4.805504512,5.541096175,6.373506209,7.311398989,8.363875146,9.540477625,10.85119763,12.30648042,13.91723108,15.69482007,17.65108875,19.5}
    local scaling = math.ceil(extraAntes/16)
    local num = list[ante % 16+1]
    --Antes 17-32

    if(scaling == 1) then
        print(2)
        return 10^(10^to_big(num))
    end
    --Antes 33-48
    if(scaling == 2) then
        return 10^10^10^to_big(num)
    end
    extraAntes = extraAntes-40
    if(extraAntes < 0) then
        return 10^10^10^10^to_big(num)
    end
    local arrowAmt = 2
    extraAntes = extraAntes-8
    if(extraAntes > 0) then
        arrowAmt = 3
        extraAntes = extraAntes -8
    end
    if(extraAntes > 0) then
        arrowAmt = 4
        extraAntes = extraAntes -4
    end
    if(extraAntes > 0) then
        arrowAmt = 5
        extraAntes = extraAntes -2
    end
    if(extraAntes > 0) then
        arrowAmt = arrowAmt+extraAntes
    end
    if(arrowAmt > 2) then
        if(arrowAmt>20) then
            arrowAmt = arrowAmt-20
            arrowAmt = arrowAmt*(arrowAmt+1)/2
            arrowAmt = arrowAmt+20
        end
        return orig_amt:arrow(arrowAmt,2)
    end
    return orig_amt:arrow(arrowAmt,math.max(extraAntes,2))
end
local err=end_round

