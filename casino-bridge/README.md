# Casino bridge (initial modernization)
Shared ox_lib cashier interaction for QBCore with server-side distance, amount and balance checks.

## Install
1. Install `ox_lib` and `qb-core`, then start `casino-bridge` after both.
2. Set `Config.ExchangeCoords` for your casino MLO and verify chip item registration.
3. Disable the legacy `casino_chip` resource cashier interaction to avoid duplicate exchange points.
4. Test purchases, sales, inventory-full refunds, insufficient cash, rapid repeated clicks, and reconnects on a staging server.

## Scope
This is the first isolated migration module, **not** a full conversion of blackjack, roulette, poker, slots, Inside Track, wheel or membership. Legacy resources are left unchanged until their money flows and events can be audited. The bridge assumes standard QBCore item/money APIs; other inventories require a tested adapter. Refund paths should be monitored because inventory or persistence failures can prevent automatic recovery.
