# Changelog

## [fix] - 2026-10-07

### Fixed
- Lucky wheel rewards are now chosen server-side from Config; clients can no longer request an arbitrary prize.
- Fixed undefined `slot` variable passed to AddItem in the item/weapon reward fallbacks.
- Players who never spun before are no longer blocked from the free daily spin.
- Removed call to SetVehicleProperties with an undefined table in the car reward handler.
