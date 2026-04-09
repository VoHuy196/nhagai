import re

with open('index.html', 'r', encoding='utf-8') as f:
    content = f.read()

original = content  # backup for comparison

# ============================================================
# STEP 1: Replace all UNIQUE Pancake CDN URLs
# Each fragment below uniquely identifies one image source
# ============================================================
unique_replacements = {
    # Hero main image (#w-9xiryvgi) → anh1
    '26/8c/55/23/de09d48410d6f6f2cc07965e1a293a7ca313c080e6ee4ce88ebc760e': 'images/anh1.jpg',
    # Hero blur images (#w-qj4x3hhd, #w-bg1p4pqv) → anh1
    '34/cf/a2/a2/9e6967aa7259ee3498926d74a0efe440fbe3746b293165018595f2ac': 'images/anh1.jpg',
    # Groom photo (#w-n420q3gb) → anh16
    'ba/57/df/8e/d933c7d23e93af90f571fca4ff9c520a254dd97bc72129c5eb7409a3': 'images/anh16.jpg',
    # Bride photo (#w-gp44a5y6) → anh17
    '8c/a7/b3/1d/fff3089d2fa8bb0df18b18ac3a8adda1e56c71373db37a3d435a7776': 'images/anh17.jpg',
    # Invitation left (#w-d0u5h72p) → anh4
    '2f/23/0e/af/7c025500487725e1b5e9d026e3353cf6d0af24e4c079deb4afc162ca': 'images/anh4.jpg',
    # Invitation center (#w-4ubspdqr) → anh5
    'ef/5a/ef/54/fcf62c073d1cb34889302c5482eef82d1b1d768034aa974d31810b83': 'images/anh5.jpg',
    # Invitation right (#w-0ks4opxz) → anh6
    '70/a8/46/73/f5093aa281c1aa45b246b91275c27b16149f2b0271680e57245d7005': 'images/anh6.jpg',
    # Album right 1 (#w-qhg11viu) → anh3
    '68/f6/c9/2a/d2232636059e3a84124def4c0061d5efa5a88c4de2a7d962d8ce5d11': 'images/anh3.jpg',
    # Album large left 2 (#w-l8vwe9g0) → anh7
    'dd/9c/8c/a8/87a897b01d024f8789f8083f9e089b531c2718a9a15d53e8df35459e': 'images/anh7.jpg',
    # Album small right bottom (#w-mpgcm7nj) → anh10
    '51/18/dd/f1/a0df37532a6fd765e12b1bd4e6a7e7c0abd73b2a2d4b46a6bf5c5cae': 'images/anh10.jpg',
    # Album left 3 (#w-8v54y07e) → anh11
    '19/2f/08/ba/9cbbd36cdcb549e04381d24960a29385e3cf93c9c871d2441e3e59e6': 'images/anh11.jpg',
    # Album right 3 (#w-cbljerx1) → anh12
    'bf/bd/74/d1/12e5fe573cba95d32bc536066e948593c1e7e8d983e02b6b0da34f89': 'images/anh12.jpg',
    # Album left 4 (#w-mhl75oyq) → anh13
    '1d/8e/aa/61/bbcf792d619ed12ba766e768fedad8ce41647e73b392783b22cde128': 'images/anh13.jpg',
    # Album right 4 (#w-yp735oj9) → anh14
    'a0/f8/a6/4f/94cc6154da9818df09077753959de47054802f403ee687189cda6b00': 'images/anh14.jpg',
    # Bottom blur (#w-m3yp2qdv) → anh8
    'ad/c0/11/16/06080e040619cef49e87d7e06a574eb61310d3dc4bdc9f0fec3638c9': 'images/anh8.jpg',
    # QR code popup (#w-abgvbg6t) → QRcode
    '11/83/93/27/c91fcbd3c11d401bafafc82e0178e671af2f59f3167097643b9baf99': 'images/QRcode.jpg',
}

count_total = 0
for fragment, new_url in unique_replacements.items():
    pattern = r'url\(["\']?https?://[^)]*?' + re.escape(fragment) + r'[^)]*?["\']?\)'
    matches = re.findall(pattern, content)
    count = len(matches)
    count_total += count
    content = re.sub(pattern, f'url({new_url})', content)
    print(f"  [{count} hits] {fragment[:30]}... → {new_url}")

print(f"\nStep 1 done: {count_total} unique URL replacements")

# ============================================================
# STEP 2: Handle SHARED URL (used by ogeg490e AND typml06f)
# Fragment: 7f/6f/61/20/2b9e24ef51d59835b6c74e6218402757d78081a5f9bd66fa867b8964
# ogeg490e → anh2.jpg, typml06f → anh15.jpg
# ============================================================
shared_fragment = '7f/6f/61/20/2b9e24ef51d59835b6c74e6218402757d78081a5f9bd66fa867b8964'
shared_pattern = r'url\(["\']?https?://[^)]*?' + re.escape(shared_fragment) + r'[^)]*?["\']?\)'
shared_matches = re.findall(shared_pattern, content)
print(f"\nStep 2: Shared URL has {len(shared_matches)} occurrences")

# First replace ALL with anh2.jpg
content = re.sub(shared_pattern, 'url(images/anh2.jpg)', content)

# Then fix typml06f specifically to anh15.jpg
# Pattern: #w-typml06f .image-background{...url(images/anh2.jpg)...}
content = re.sub(
    r'(#w-typml06f \.image-background\{[^}]*?)url\(images/anh2\.jpg\)',
    r'\1url(images/anh15.jpg)',
    content
)
print("  ogeg490e → images/anh2.jpg")
print("  typml06f → images/anh15.jpg")

# ============================================================
# STEP 3: Handle n1a07a7d URL (also used in favicon/OG)
# Fragment: 80/ef/b5/09/6c1db6a25f68b4dca4e44de83c669091bc58a717a12864f63da21990
# n1a07a7d → anh9.jpg
# ============================================================
n1_fragment = '80/ef/b5/09/6c1db6a25f68b4dca4e44de83c669091bc58a717a12864f63da21990'
n1_pattern = r'url\(["\']?https?://[^)]*?' + re.escape(n1_fragment) + r'[^)]*?["\']?\)'
n1_matches = re.findall(n1_pattern, content)
print(f"\nStep 3: n1a07a7d URL has {len(n1_matches)} occurrences in CSS")
content = re.sub(n1_pattern, 'url(images/anh9.jpg)', content)
print("  n1a07a7d → images/anh9.jpg")

# ============================================================
# STEP 4: Fix favicon and OG image meta tags
# ============================================================
# Favicon - match href containing the pancake URL
content = re.sub(
    r'(<link[^>]*rel="icon"[^>]*href=")[^"]*(")',
    r'\1images/anh1.jpg\2',
    content
)
print("\nStep 4: Favicon → images/anh1.jpg")

# OG Image
content = re.sub(
    r'(<meta[^>]*property="og:image"[^>]*content=")[^"]*(")',
    r'\1images/anh1.jpg\2',
    content
)
print("  OG image → images/anh1.jpg")

# Also fix the favicon URL that uses the same n1 fragment in href=""
# This is the <link href="https://content.pancake.vn/1/s75x50/fwebp/80/ef/..." rel="icon">
content = re.sub(
    r'(href=")[^"]*' + re.escape(n1_fragment) + r'[^"]*(")',
    r'\1images/anh1.jpg\2',
    content
)

# ============================================================
# STEP 5: Verify and save
# ============================================================
# Count remaining pancake image URLs (excluding fonts, scripts, SVGs, audio, etc.)
remaining = re.findall(r'url\([^)]*content\.pancake\.vn[^)]*(?:jpeg|jpg|png|jfif|webp)[^)]*\)', content)
print(f"\nRemaining Pancake image URLs in CSS: {len(remaining)}")
for r in remaining[:10]:
    print(f"  {r[:100]}...")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(content)

print(f"\n✅ File saved! Total changes in file.")
