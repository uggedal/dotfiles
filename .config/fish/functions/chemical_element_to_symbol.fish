function chemical_element_to_symbol
  set -l elements hydrogen helium lithium beryllium boron carbon nitrogen oxygen fluorine neon sodium magnesium aluminium silicon phosphorus sulfur chlorine argon potassium calcium scandium titanium vanadium chromium manganese iron cobalt nickel copper zinc gallium germanium arsenic selenium bromine krypton rubidium strontium yttrium zirconium niobium molybdenum technetium ruthenium rhodium palladium silver cadmium indium tin antimony tellurium iodine xenon cesium barium lanthanum cerium praseodymium neodymium promethium samarium europium gadolinium terbium dysprosium holmium erbium thulium ytterbium lutetium hafnium tantalum tungsten rhenium osmium iridium platinum gold mercury thallium lead bismuth polonium astatine radon francium radium actinium thorium protactinium uranium neptunium plutonium americium curium berkelium californium einsteinium fermium mendelevium nobelium lawrencium rutherfordium dubnium seaborgium bohrium hassium meitnerium darmstadtium roentgenium copernicium ununtrium flerovium ununpentium livermorium ununseptium ununoctium
  set -l symbols h he li be b c n o f ne na mg al si p s cl ar k ca sc ti v cr mn fe co ni cu zn ga ge as se br kr rb sr y zr nb mo tc ru rh pd ag cd in sn sb te i xe cs ba la ce pr nd pm sm eu gd tb dy ho er tm yb lu hf ta w re os ir pt au hg tl pb bi po at rn fr ra ac th pa u np pu am cm bk cf es fm md no lr rf db sg bh hs mt ds rg cn uut fl uup lv uus uuo

  if contains $argv[1] $elements
    echo $symbols[(contains -i $argv[1] $elements)]
  else
    echo $argv[1]
  end
end
