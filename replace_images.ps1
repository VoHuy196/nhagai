$file = "c:\Users\APC\Documents\GitHub\nhagai\index.html"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Define replacements: old URL fragment => new local path
$replacements = @{
    # Hero main image - 9xiryvgi
    'https://content.pancake.vn/web-media/26/8c/55/23/de09d48410d6f6f2cc07965e1a293a7ca313c080e6ee4ce88ebc760e-w:736-h:1104-l:44522-t:image/jpeg.jfif' = 'images/anh1.jpg'
    # Hero blur - qj4x3hhd & bg1p4pqv (appears with quotes)
    'https://content.pancake.vn/1/fwebp/34/cf/a2/a2/9e6967aa7259ee3498926d74a0efe440fbe3746b293165018595f2ac-w:420-h:800-l:272644-t:image/png.png' = 'images/anh1.jpg'
    # Groom - n420q3gb
    'https://content.pancake.vn/web-media/ba/57/df/8e/d933c7d23e93af90f571fca4ff9c520a254dd97bc72129c5eb7409a3-w:966-h:1449-l:265863-t:image/jpeg.jpg' = 'images/anh16.jpg'
    # Bride - gp44a5y6
    'https://content.pancake.vn/web-media/8c/a7/b3/1d/fff3089d2fa8bb0df18b18ac3a8adda1e56c71373db37a3d435a7776-w:966-h:1449-l:189792-t:image/jpeg.jpg' = 'images/anh17.jpg'
    # Invitation left - d0u5h72p
    'https://content.pancake.vn/1/s522x783/fwebp/2f/23/0e/af/7c025500487725e1b5e9d026e3353cf6d0af24e4c079deb4afc162ca-w:966-h:1449-l:220355-t:image/jpeg.jpg' = 'images/anh4.jpg'
    # Invitation center - 4ubspdqr
    'https://content.pancake.vn/1/s560x840/fwebp/ef/5a/ef/54/fcf62c073d1cb34889302c5482eef82d1b1d768034aa974d31810b83-w:966-h:1449-l:415595-t:image/jpeg.jpg' = 'images/anh5.jpg'
    # Invitation right - 0ks4opxz
    'https://content.pancake.vn/1/s522x783/fwebp/70/a8/46/73/f5093aa281c1aa45b246b91275c27b16149f2b0271680e57245d7005-w:966-h:1449-l:307641-t:image/jpeg.jpg' = 'images/anh6.jpg'
    # Album right 1 - qhg11viu
    'https://content.pancake.vn/web-media/68/f6/c9/2a/d2232636059e3a84124def4c0061d5efa5a88c4de2a7d962d8ce5d11-w:966-h:1449-l:71766-t:image/jpeg.jpg' = 'images/anh3.jpg'
    # Album large left 2 - l8vwe9g0
    'https://content.pancake.vn/web-media/dd/9c/8c/a8/87a897b01d024f8789f8083f9e089b531c2718a9a15d53e8df35459e-w:966-h:1449-l:250805-t:image/jpeg.jpg' = 'images/anh7.jpg'
    # Album small right bottom - mpgcm7nj
    'https://content.pancake.vn/1/s587x881/51/18/dd/f1/a0df37532a6fd765e12b1bd4e6a7e7c0abd73b2a2d4b46a6bf5c5cae-w:966-h:1449-l:303373-t:image/jpeg.jpg' = 'images/anh10.jpg'
    # Album left 3 - 8v54y07e
    'https://content.pancake.vn/web-media/19/2f/08/ba/9cbbd36cdcb549e04381d24960a29385e3cf93c9c871d2441e3e59e6-w:966-h:1449-l:170170-t:image/jpeg.jpg' = 'images/anh11.jpg'
    # Album right 3 - cbljerx1
    'https://content.pancake.vn/web-media/bf/bd/74/d1/12e5fe573cba95d32bc536066e948593c1e7e8d983e02b6b0da34f89-w:966-h:1449-l:117292-t:image/jpeg.jpg' = 'images/anh12.jpg'
    # Album left 4 - mhl75oyq
    'https://content.pancake.vn/web-media/1d/8e/aa/61/bbcf792d619ed12ba766e768fedad8ce41647e73b392783b22cde128-w:966-h:1449-l:192299-t:image/jpeg.jpg' = 'images/anh13.jpg'
    # Album right 4 - yp735oj9
    'https://content.pancake.vn/web-media/a0/f8/a6/4f/94cc6154da9818df09077753959de47054802f403ee687189cda6b00-w:966-h:1449-l:346091-t:image/jpeg.jpg' = 'images/anh14.jpg'
    # Bottom blur - m3yp2qdv
    'https://content.pancake.vn/web-media/ad/c0/11/16/06080e040619cef49e87d7e06a574eb61310d3dc4bdc9f0fec3638c9-w:854-h:1280-l:259362-t:image/jpeg.png' = 'images/anh8.jpg'
    # n1a07a7d - landscape
    'https://content.pancake.vn/1/s788x526/80/ef/b5/09/6c1db6a25f68b4dca4e44de83c669091bc58a717a12864f63da21990-w:966-h:644-l:136924-t:image/jpeg.jpg' = 'images/anh9.jpg'
    # QR code popup - abgvbg6t
    'https://content.pancake.vn/1/s780x1688/fwebp/11/83/93/27/c91fcbd3c11d401bafafc82e0178e671af2f59f3167097643b9baf99-w:1284-h:2778-l:390596-t:image/jpeg.jpg' = 'images/QRcode.jpg'
}

$count = 0
foreach ($old in $replacements.Keys) {
    $matches = [regex]::Matches($content, [regex]::Escape($old))
    $count += $matches.Count
    Write-Host "[$($matches.Count) hits] $($old.Substring(0, [Math]::Min(60, $old.Length)))... => $($replacements[$old])"
    $content = $content.Replace($old, $replacements[$old])
}
Write-Host "`nStep 1: $count unique URL replacements done"

# Step 2: Handle SHARED URL - ogeg490e uses same base URL as typml06f
# ogeg490e -> anh2, typml06f -> anh15
# First replace ogeg490e (exact URL from CSS)
$sharedUrl = 'https://content.pancake.vn/web-media/7f/6f/61/20/2b9e24ef51d59835b6c74e6218402757d78081a5f9bd66fa867b8964-w:966-h:1449-l:61481-t:image/jpeg.jpg'
$sharedMatches = [regex]::Matches($content, [regex]::Escape($sharedUrl))
Write-Host "`nStep 2: Shared URL has $($sharedMatches.Count) occurrences"

# Replace ALL with anh2.jpg first
$content = $content.Replace($sharedUrl, 'images/anh2.jpg')

# Then fix typml06f to anh15.jpg (find the context-specific occurrence)
$content = $content.Replace('#w-typml06f .image-background{width:400.66666666666663px;height:601px;top:-101px;left:0px;background:center center/ cover no-repeat scroll content-box url(images/anh2.jpg)', '#w-typml06f .image-background{width:400.66666666666663px;height:601px;top:-101px;left:0px;background:center center/ cover no-repeat scroll content-box url(images/anh15.jpg)')
Write-Host "  ogeg490e => images/anh2.jpg"
Write-Host "  typml06f => images/anh15.jpg"

# Step 3: Favicon
$content = $content -replace '(<link[^>]*rel="icon"[^>]*href=")[^"]*(")', '${1}images/anh1.jpg${2}'
Write-Host "`nStep 3: Favicon => images/anh1.jpg"

# Step 4: OG Image
$content = $content -replace '(<meta[^>]*property="og:image"[^>]*content=")[^"]*(")', '${1}images/anh1.jpg${2}'
Write-Host "  OG image => images/anh1.jpg"

# Step 5: Also fix the favicon <link href> that has the 80/ef/b5/09 fragment
$faviconOld = 'https://content.pancake.vn/1/s75x50/fwebp/80/ef/b5/09/6c1db6a25f68b4dca4e44de83c669091bc58a717a12864f63da21990-w:966-h:644-l:136924-t:image/jpeg.jpg'
$content = $content.Replace($faviconOld, 'images/anh1.jpg')
Write-Host "  Favicon link href => images/anh1.jpg"

# Step 6: OG image URL (may differ slightly)
$ogOld = 'https://content.pancake.vn/1//80/ef/b5/09/6c1db6a25f68b4dca4e44de83c669091bc58a717a12864f63da21990-w:966-h:644-l:136924-t:image/jpeg.jpg'
$content = $content.Replace($ogOld, 'images/anh1.jpg')
Write-Host "  OG meta content => images/anh1.jpg"

# Save
[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Host "`n Done! File saved."
