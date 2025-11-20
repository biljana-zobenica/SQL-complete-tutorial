
--> JOINs

-- characters + inventory tables
-- how many items each character has?

SELECT
    characters.id,
    characters.name,
    inventory.item_id,
    inventory.quantity
FROM `fantasy.characters` AS characters
    JOIN `fantasy.inventory` AS inventory
    ON inventory.character_id = characters.id
ORDER BY characters.id, inventory.item_id;

--> Using aliases and multiple joins:

SELECT
    c.id,
    c.name,
    i.item_id,
    i.quantity,
    it.name AS item_name,
    it.power
FROM `fantasy.characters` c
    JOIN `fantasy.inventory` i
    ON i.character_id = c.id
    JOIN `fantasy.items` it
    ON i.item_id = it.id
ORDER BY c.id, i.item_id;