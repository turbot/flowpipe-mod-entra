mod "entra" {
  title         = "Microsoft Entra ID"
  description   = "Run pipelines to supercharge your Entra ID workflows using Flowpipe."
  color         = "#0089D6"
  documentation = file("./README.md")
  icon          = "/images/mods/turbot/entra.svg"
  categories    = ["library", "access management", "public cloud"]

  opengraph {
    title       = "Microsoft Entra ID Mod for Flowpipe"
    description = "Run pipelines to supercharge your Entra ID workflows using Flowpipe."
    image       = "/images/mods/turbot/entra-social-graphic.png"
  }

  require {
    flowpipe {
      min_version = "1.0.0"
    }
  }
}
