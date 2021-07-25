package moviespicker.model;

public enum Language {
    ENGLISH,
    HINDI;

    public static Language parse(String s) {
        switch (s.toUpperCase()) {
            case "HINDI": return HINDI;
            case "ENGLISH":
            default:
                return ENGLISH;
        }
    }
}
