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
      link: "https://github.com/hfshr/jqbr",
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
          title: "Filter definition",
          link: "/filters",
        },
        {
          title: "Plugins",
          link: "/plugins",
        },
        {
          title: "Widgets",
          link: "/widgets",
        },
        {
          title: "Advanced",
          link: "/advanced",
        },
      ],
    },
    {
      title: "Reference",
      children: [
        { title: "Filter table", link: "/references/filter_table" },
        { title: "queryBuilderInput", link: "/references/queryBuilderInput" },
        { title: "Run jqbr demo", link: "/references/run_jqbr_demo" },
        { title: "updateQueryBuilder", link: "/references/updateQueryBuilder" },
        { title: "useQueryBuilder", link: "/references/useQueryBuilder" },
      ],
    },
    {
      title: "GitHub",
      link: "https://github.com/hfshr/jqbr",
    },
  ],
});
