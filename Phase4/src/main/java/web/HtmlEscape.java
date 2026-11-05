package web;

/** Escapes player supplied text before it is placed in JSP markup. */
public final class HtmlEscape {
    private HtmlEscape() { }

    public static String escape(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
