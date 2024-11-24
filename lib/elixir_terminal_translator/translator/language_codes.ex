defmodule ElixirTerminalTranslator.Translator.LanguageCodes do
  @language_aliases %{
    afrikaans: "af",
    albanian: "sq",
    shqip: "sq",
    amharic: "am",
    አማርኛ: "am",
    arabic: "ar",
    عربي: "ar",
    armenian: "hy",
    հայերեն: "hy",
    assamese: "as",
    অসমীয়া: "as",
    aymara: "ay",
    azerbaijani: "az",
    azərbaycan: "az",
    bambara: "bm",
    basque: "eu",
    euskara: "eu",
    belarusian: "be",
    беларуская: "be",
    bengali: "bn",
    বাংলা: "bn",
    bangla: "bn",
    bhojpuri: "bho",
    भोजपुरी: "bho",
    bosnian: "bs",
    bosanski: "bs",
    bulgarian: "bg",
    български: "bg",
    catalan: "ca",
    català: "ca",
    cebuano: "ceb",
    chinese: "zh",
    中文: "zh",
    zhongwen: "zh",
    chinese_simplified: "zh-CN",
    简体中文: "zh-CN",
    chinese_traditional: "zh-TW",
    繁體中文: "zh-TW",
    mandarin: "zh",
    普通话: "zh",
    corsican: "co",
    corsu: "co",
    croatian: "hr",
    hrvatski: "hr",
    czech: "cs",
    čeština: "cs",
    cestina: "cs",
    danish: "da",
    dansk: "da",
    dhivehi: "dv",
    ދިވެހި: "dv",
    dogri: "doi",
    डोगरी: "doi",
    dutch: "nl",
    nederlands: "nl",
    english: "en",
    esperanto: "eo",
    estonian: "et",
    eesti: "et",
    ewe: "ee",
    filipino: "fil",
    tagalog: "fil",
    finnish: "fi",
    suomi: "fi",
    french: "fr",
    français: "fr",
    francais: "fr",
    frisian: "fy",
    frysk: "fy",
    galician: "gl",
    galego: "gl",
    georgian: "ka",
    ქართული: "ka",
    german: "de",
    deutsch: "de",
    greek: "el",
    ελληνικά: "el",
    ellinika: "el",
    guarani: "gn",
    gujarati: "gu",
    ગુજરાતી: "gu",
    haitian: "ht",
    haitian_creole: "ht",
    kreyòl: "ht",
    kreyol: "ht",
    hausa: "ha",
    hawaiian: "haw",
    hebrew: "he",
    עברית: "he",
    ivrit: "he",
    hindi: "hi",
    हिन्दी: "hi",
    hmong: "hmn",
    hungarian: "hu",
    magyar: "hu",
    icelandic: "is",
    íslenska: "is",
    islenska: "is",
    igbo: "ig",
    ilokano: "ilo",
    indonesian: "id",
    bahasa_indonesia: "id",
    irish: "ga",
    gaeilge: "ga",
    gaelic: "ga",
    italian: "it",
    italiano: "it",
    japanese: "ja",
    日本語: "ja",
    nihongo: "ja",
    javanese: "jv",
    basa_jawa: "jv",
    kannada: "kn",
    ಕನ್ನಡ: "kn",
    kazakh: "kk",
    қазақ: "kk",
    qazaq: "kk",
    khmer: "km",
    ខ្មែរ: "km",
    kinyarwanda: "rw",
    konkani: "gom",
    korean: "ko",
    한국어: "ko",
    hangugeo: "ko",
    krio: "kri",
    kurdish: "ku",
    kurdí: "ku",
    kurdish_sorani: "ckb",
    کوردی: "ckb",
    kyrgyz: "ky",
    кыргызча: "ky",
    lao: "lo",
    laotian: "lo",
    ລາວ: "lo",
    latin: "la",
    latvian: "lv",
    latviešu: "lv",
    lingala: "ln",
    lithuanian: "lt",
    lietuvių: "lt",
    luganda: "lg",
    luxembourgish: "lb",
    lëtzebuergesch: "lb",
    macedonian: "mk",
    македонски: "mk",
    maithili: "mai",
    मैथिली: "mai",
    malagasy: "mg",
    malay: "ms",
    bahasa_melayu: "ms",
    malaysian: "ms",
    malayalam: "ml",
    മലയാളം: "ml",
    maltese: "mt",
    malti: "mt",
    maori: "mi",
    māori: "mi",
    marathi: "mr",
    मराठी: "mr",
    meiteilon: "mni-Mtei",
    manipuri: "mni-Mtei",
    মৈতৈলোন্: "mni-Mtei",
    mizo: "lus",
    mongolian: "mn",
    монгол: "mn",
    myanmar: "my",
    burmese: "my",
    မြန်မာ: "my",
    nepali: "ne",
    नेपाली: "ne",
    nepalese: "ne",
    norwegian: "no",
    norsk: "no",
    nyanja: "ny",
    chichewa: "ny",
    odia: "or",
    oriya: "or",
    ଓଡ଼ିଆ: "or",
    oromo: "om",
    pashto: "ps",
    پښتو: "ps",
    persian: "fa",
    farsi: "fa",
    فارسی: "fa",
    polish: "pl",
    polski: "pl",
    portuguese: "pt",
    português: "pt",
    portugues: "pt",
    punjabi: "pa",
    ਪੰਜਾਬੀ: "pa",
    quechua: "qu",
    romanian: "ro",
    română: "ro",
    romana: "ro",
    russian: "ru",
    русский: "ru",
    russkiy: "ru",
    samoan: "sm",
    sanskrit: "sa",
    संस्कृत: "sa",
    scots_gaelic: "gd",
    scottish_gaelic: "gd",
    gàidhlig: "gd",
    sepedi: "nso",
    serbian: "sr",
    српски: "sr",
    srpski: "sr",
    sesotho: "st",
    shona: "sn",
    sindhi: "sd",
    سنڌي: "sd",
    sinhala: "si",
    sinhalese: "si",
    සිංහල: "si",
    slovak: "sk",
    slovenčina: "sk",
    slovenian: "sl",
    slovenščina: "sl",
    somali: "so",
    spanish: "es",
    español: "es",
    espanol: "es",
    castilian: "es",
    castellano: "es",
    sundanese: "su",
    basa_sunda: "su",
    swahili: "sw",
    kiswahili: "sw",
    swedish: "sv",
    svenska: "sv",
    tajik: "tg",
    тоҷикӣ: "tg",
    tamil: "ta",
    தமிழ்: "ta",
    tatar: "tt",
    татар: "tt",
    telugu: "te",
    తెలుగు: "te",
    thai: "th",
    ไทย: "th",
    tigrinya: "ti",
    ትግርኛ: "ti",
    tsonga: "ts",
    turkish: "tr",
    türkçe: "tr",
    turkce: "tr",
    turkmen: "tk",
    türkmen: "tk",
    twi: "ak",
    akan: "ak",
    ukrainian: "uk",
    українська: "uk",
    urdu: "ur",
    اردو: "ur",
    uyghur: "ug",
    ئۇيغۇر: "ug",
    uzbek: "uz",
    oʻzbek: "uz",
    vietnamese: "vi",
    tiếng_việt: "vi",
    tieng_viet: "vi",
    welsh: "cy",
    cymraeg: "cy",
    xhosa: "xh",
    isiXhosa: "xh",
    yiddish: "yi",
    ייִדיש: "yi",
    yoruba: "yo",
    zulu: "zu",
    isiZulu: "zu"
    }

  @google_languages MapSet.new([
    "af", "sq", "am", "ar", "hy", "as", "ay", "az", "bm", "eu", "be", "bn", "bho", "bs",
    "bg", "ca", "ceb", "zh", "zh-CN", "zh-TW", "co", "hr", "cs", "da", "dv", "doi", "nl",
    "en", "eo", "et", "ee", "fil", "fi", "fr", "fy", "gl", "ka", "de", "el", "gn", "gu",
    "ht", "ha", "haw", "he", "hi", "hmn", "hu", "is", "ig", "ilo", "id", "ga", "it", "ja",
    "jv", "kn", "kk", "km", "rw", "gom", "ko", "kri", "ku", "ckb", "ky", "lo", "la", "lv",
    "ln", "lt", "lg", "lb", "mk", "mai", "mg", "ms", "ml", "mt", "mi", "mr", "mni-Mtei",
    "lus", "mn", "my", "ne", "no", "ny", "or", "om", "ps", "fa", "pl", "pt", "pa", "qu",
    "ro", "ru", "sm", "sa", "gd", "nso", "sr", "st", "sn", "sd", "si", "sk", "sl", "so",
    "es", "su", "sw", "sv", "tl", "tg", "ta", "tt", "te", "th", "ti", "ts", "tr", "tk",
    "ak", "uk", "ur", "ug", "uz", "vi", "cy", "xh", "yi", "yo", "zu"
  ])

  @deepl_languages MapSet.new([
    "BG",  # Bulgarian
    "CS",  # Czech
    "DA",  # Danish
    "DE",  # German
    "EL",  # Greek
    "EN",  # English
    "EN-GB", # British English
    "EN-US", # American English
    "ES",  # Spanish
    "ET",  # Estonian
    "FI",  # Finnish
    "FR",  # French
    "HU",  # Hungarian
    "ID",  # Indonesian
    "IT",  # Italian
    "JA",  # Japanese
    "KO",  # Korean
    "LT",  # Lithuanian
    "LV",  # Latvian
    "NB",  # Norwegian (Bokmål)
    "NL",  # Dutch
    "PL",  # Polish
    "PT",  # Portuguese
    "PT-BR", # Brazilian Portuguese
    "PT-PT", # European Portuguese
    "RO",  # Romanian
    "RU",  # Russian
    "SK",  # Slovak
    "SL",  # Slovenian
    "SV",  # Swedish
    "TR",  # Turkish
    "UK",  # Ukrainian
    "ZH"   # Chinese (simplified)
  ])

  def supported_by_google?(lang_alias) when is_atom(lang_alias) do
    code = @language_aliases[lang_alias]
    supported_by_google?(code)
  end

  def supported_by_google?(code) do
    MapSet.member?(@google_languages, code)
  end

  def supported_by_deepl?(lang_alias) when is_atom(lang_alias) do
    code = @language_aliases[lang_alias]
    supported_by_google?(code)
  end

  def supported_by_deepl?(code) do
    MapSet.member?(@deepl_languages, code)
  end

  def list_google_languages do
    @google_languages
  end

  def list_deepl_languages do
    @deepl_languages
  end
end
