pragma solidity ^0.8.11;

interface IVaderMinterExtended {
    struct Limits {
        uint256 fee;
        uint256 mintLimit;
        uint256 burnLimit;
    }

    event PublicMintCapChanged(
        uint256 previousPublicMintCap,
        uint256 publicMintCap
    );

    event PublicMintFeeChanged(
        uint256 previousPublicMintFee,
        uint256 publicMintFee
    );

    event PartnerMintCapChanged(
        uint256 previousPartnerMintCap,
        uint256 partnerMintCap
    );

    event PartnerMintFeeChanged(
        uint256 previousPartnercMintFee,
        uint256 partnerMintFee
    );

    event DailyLimitsChanged(Limits previousLimits, Limits nextLimits);
    event WhitelistPartner(
        address partner,
        uint256 mintLimit,
        uint256 burnLimit,
        uint256 fee
    );

    function lbt() external view returns (address);

    // The 24 hour limits on USDV mints that are available for public minting and burning as well as the fee.
    function dailyLimits() external view returns (Limits memory);

    // The current cycle end timestamp
    function cycleTimestamp() external view returns (uint);

    // The current cycle cumulative mints
    function cycleMints() external view returns (uint);

    // The current cycle cumulative burns
    function cycleBurns() external view returns (uint);

    function partnerLimits(address) external view returns (Limits memory);

    // USDV Contract for Mint / Burn Operations
    function usdv() external view returns (address);

    function getPublicFee() external view returns (uint256);

    function mint(uint256 vAmount, uint256 uAmountMinOut)
    external
    returns (uint256 uAmount);

    /*
     * @dev Public burn function that receives USDV and mints Vader.
     * @param uAmount USDV amount to burn.
     * @param vAmountMinOut Vader minimum amount to get back from the burn.
     * @returns vAmount in Vader, represents the Vader amount received from the burn.
     *
     **/
    function burn(uint256 uAmount, uint256 vAmountMinOut)
    external
    returns (uint256 vAmount);
    /*
     * @dev Partner mint function that receives Vader and mints USDV.
     * @param vAmount Vader amount to burn.
     * @returns uAmount in USDV, represents the USDV amount received from the mint.
     *
     * Requirements:
     * - Can only be called by whitelisted partners.
     **/
    function partnerMint(uint256 vAmount) external returns (uint256 uAmount);
    /*
     * @dev Partner burn function that receives USDV and mints Vader.
     * @param uAmount USDV amount to burn.
     * @returns vAmount in Vader, represents the Vader amount received from the mint.
     *
     * Requirements:
     * - Can only be called by whitelisted partners.
     **/
    function partnerBurn(uint256 uAmount) external returns (uint256 vAmount);


    function increasePartnerMintLimit(address _partner, uint256 _amount)
    external;
    function setPartnerFee(address _partner, uint256 _fee) external;
    function increasePartnerBurnLimit(address _partner, uint256 _amount)
    external;
    function whitelistPartner(
        address _partner,
        uint256 _fee,
        uint256 _mintLimit,
        uint256 _burnLimit,
        uint256 _lockDuration
    ) external ;
}
