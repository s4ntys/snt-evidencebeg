Config = {}

-- Toggle debug output
Config.Debug = true -- Set false in production

-- Evidence bag item name (must exist in qb-core/shared/items.lua)
Config.EvidenceBagItem = 'evidencebag'

-- Default stash configuration
Config.StashSlots = 20
Config.StashWeight = 25000 -- grams

-- Client command that prompts for record number & creates bag
Config.CreateCommand = 'makebag' -- /makebag

-- List of jobs allowed to create/open evidence bags
Config.AllowedJobs = {
    police = true,
    sheriff = true,
}

-- SQL archive table (see sql/evidencebags.sql)
Config.ArchiveTable = 'evidence_bags'
