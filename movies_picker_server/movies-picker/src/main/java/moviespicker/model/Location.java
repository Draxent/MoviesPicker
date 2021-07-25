package moviespicker.model;

public enum Location {
    BANGALORE,
    CHENNAI,
    DELHI,
    PUNE;

    public static Location parse(String s) {
        switch (s.toUpperCase()) {
            case "BANGALORE": return BANGALORE;
            case "CHENNAI": return CHENNAI;
            case "DELHI": return DELHI;
            case "PUNE":
            default:
            return PUNE;
        }
    }
}
