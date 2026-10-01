const fs = require('fs');

const siteOrigin = 'https://kvallespin.github.io';
const section = 'finance';
const slug = 'the-worlds-largest-lbo-why-pif-wanted-electronic-arts';
const canonicalUrl = `${siteOrigin}/${section}/${slug}`;
const listenerPath = `content/substack-${slug}.xml`;

// Original publication date: 2026-08-12 -> RFC 822
const pubDate = 'Wed, 12 Aug 2026 00:00:00 GMT';

const title = "The world's largest LBO: why PIF wanted Electronic Arts";
const subtitle = "USD 36 billion of equity behind USD 18 billion of debt. The leverage is inverted, and the inversion is the point.";
const author = 'Ken Vallespin';

// Read converted HTML body
let htmlBody = fs.readFileSync('C:/Users/kenne/dsh-lab/workspace/article-body.html', 'utf8');

// Wrap in CDATA-safe structure. Check for CDATA terminator in content.
if (htmlBody.includes(']]>')) {
  console.error('ERROR: Content contains literal CDATA terminator. Must split.');
  process.exit(1);
}

const xml = `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0"
  xmlns:content="http://purl.org/rss/1.0/modules/content/"
  xmlns:dc="http://purl.org/dc/elements/1.1/">
  <channel>
    <title>Ken Vallespin - Substack import feed</title>
    <link>${siteOrigin}/</link>
    <description>Temporary one-post RSS feed for Substack import.</description>
    <language>en-us</language>
    <generator>Manual temporary RSS export</generator>
    <lastBuildDate>${pubDate}</lastBuildDate>
    <item>
      <title><![CDATA[${title}]]></title>
      <link>${canonicalUrl}</link>
      <guid isPermaLink="true">${canonicalUrl}</guid>
      <dc:creator><![CDATA[${author}]]></dc:creator>
      <pubDate>${pubDate}</pubDate>
      <description><![CDATA[${subtitle}]]></description>
      <content:encoded><![CDATA[
${htmlBody}
      ]]></content:encoded>
    </item>
  </channel>
</rss>`;

fs.writeFileSync(listenerPath, xml, 'utf8');
console.log(`Written: ${listenerPath}`);
console.log(`Size: ${xml.length} bytes`);

// Verify with XML parser
try {
  const parsed = new (require('xmldom').DOMParser)();
  // xmldom may not be installed; try built-in approach instead
  console.log('Note: Use PowerShell [xml] cast to validate.');
} catch(e) {
  console.log('Validation note:', e.message);
}
