# Casino modernization research and implementation roadmap

## Sources reviewed
- RyFiction/casino-reboot — upstream baseline; preserve attribution and check licenses.
- rubbertoe98/DiamondBlackjack — networked tables, configurable locations and seats; reference behavior only.
- ItsANoBrainer/qb-luckywheel — podium vehicle and interior-aware loading (GPL-3.0; do not transplant code without license compliance).
- Sn0wBiT/qb-tpnrp-lucky-wheel — exclusive spin lock and reward flow.
- kubakrakowiak/program_casino_fivem — modular game configuration (MIT).
- Nou4r/nours-casino — play-money UI concepts, not a FiveM backend.

## Implementation status
- [x] Isolated ox_lib cashier module
- [x] ox_inventory / qb-inventory item adapter for cashier
- [x] Server distance, membership, amount and balance validation
- [ ] Full gameplay integrations (blackjack, roulette, poker, slots, Inside Track, wheel)
- [ ] Shared ledger with durable transaction IDs and idempotency
- [ ] Unified bet debit / settlement / refund service
- [ ] Configurable table tiers, limits and responsible-play cooldowns
- [ ] Modern accessible NUI for game tables and VIP panel
- [ ] Persistent cooldowns, audit logs, administrative dashboard
- [ ] Integration tests on a staging FiveM server

## Architecture
Keep existing resources unchanged until verified. New modules should call a shared server-side casino economy service; clients only submit intents (bet, hit, stand, spin), never payout amounts or winning outcomes. Lock seats and rounds server-side. Persist settled transaction IDs to prevent duplicate rewards after reconnect/restart. Use server RNG and explicit game rules; test distribution statistically. The UI should never be a source of truth.

## Priority
1. Audit legacy network events for trust boundaries and double payout vulnerabilities.
2. Implement transaction ledger with database-backed idempotency, then migrate games one at a time.
3. Create a common casino design system (black/gold, responsive controls, keyboard access, no full-screen grey overlays).
4. Add VIP tiers, table limits and synchronized multiplayer seating.
5. Run economy stress tests, reconnect/restart tests, and multiplayer tests.

## Known limitations
Current bridge is **not production-ready**. QBCore and inventory operations may not be atomic, so rollback attempts can fail. Confirm ox_inventory compatibility with the actual framework configuration. Verify the cashier coordinates, item names and duplicate legacy handlers. No in-game tests have been performed.
