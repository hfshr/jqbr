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
      title: "Advanced",
      link: "/advanced",
    },
    {
      title: "Reference",
      children: [
        { title: "Filter table", link: "/references/filter_table" },
        { title: "queryBuilderInput", link: "/references/queryBuilderInput" },
        { title: "updateQueryBuilder", link: "/references/updateQueryBuilder" },
      ],
    },
    {
      title: "GitHub",
      link: "https://github.com/hfshr/qbr",
    },
  ],
});
