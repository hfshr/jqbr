new Docute({
  target: "#docute",
  detectSystemDarkTheme: true,
  darkThemeToggler: true,
  highlight: ["r", "javascript"],
  nav: [
    {
      title: "Home",
      link: "/",
    },
    {
      title: "Github",
      link: "https://github.com/hfshr/qbr",
    },
  ],
  sidebar: [
    // A sidebar item, with child links
    {
      title: "Guide",
      children: [
        {
          title: "Getting Started",
          link: "/getting-started",
        },
        {
          title: "Basic usage",
          link: "/basic-usage",
        },
        {
          title: "Plugins",
          link: "/plugins",
        },
        {
          title: "Widgets",
          link: "/widgets",
        },
      ],
    },
    {
      title: "Updating",
      link: "/updating",
    },
    {
      title: "Advanced",
      link: "/advanced",
    },
    // An external link
    {
      title: "GitHub",
      link: "https://github.com/hfshr/qbr",
    },
  ],
});
