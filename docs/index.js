new Docute({
  target: "#docute",
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
          title: "Installation",
          link: "/installation",
        },
      ],
    },
    // An external link
    {
      title: "GitHub",
      link: "https://github.com/egoist/docute",
    },
  ],
});
