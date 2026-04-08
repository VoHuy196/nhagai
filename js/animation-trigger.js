// Enable animations on all elements with animation CSS rules
document.addEventListener('DOMContentLoaded', function() {
  // Get all elements that have animation styles defined in CSS
  const animationElements = document.querySelectorAll('[id^="w-"]');
  
  // Function to add animation class
  function addAnimationClass(element) {
    element.classList.add('animation');
  }
  
  // Option 1: Add animation immediately on page load
  animationElements.forEach(addAnimationClass);
  
  // Option 2: Add animation when elements come into view (Intersection Observer)
  if ('IntersectionObserver' in window) {
    const observerOptions = {
      threshold: 0.1,
      rootMargin: '0px'
    };
    
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('animation');
          observer.unobserve(entry.target);
        }
      });
    }, observerOptions);
    
    // Uncomment the following to use Intersection Observer instead:
    // animationElements.forEach(el => observer.observe(el));
  }
  
  console.log('Animations enabled on', animationElements.length, 'elements');
});
