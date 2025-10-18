import { ref, onMounted, onUnmounted } from 'vue';

// Intersection Observer untuk animasi on scroll
export function useScrollAnimation() {
  const isVisible = ref(false);
  const elementRef = ref<HTMLElement | null>(null);
  let observer: IntersectionObserver | null = null;

  onMounted(() => {
    if (elementRef.value) {
      observer = new IntersectionObserver(
        ([entry]) => {
          isVisible.value = entry.isIntersecting;
        },
        {
          threshold: 0.1,
          rootMargin: '50px'
        }
      );
      observer.observe(elementRef.value);
    }
  });

  onUnmounted(() => {
    if (observer) {
      observer.disconnect();
    }
  });

  return {
    isVisible,
    elementRef
  };
}

// Hover animations
export function useHoverAnimation() {
  const isHovered = ref(false);
  const isPressed = ref(false);

  const handleMouseEnter = () => {
    isHovered.value = true;
  };

  const handleMouseLeave = () => {
    isHovered.value = false;
    isPressed.value = false;
  };

  const handleMouseDown = () => {
    isPressed.value = true;
  };

  const handleMouseUp = () => {
    isPressed.value = false;
  };

  const hoverClasses = computed(() => ({
    'transform transition-all duration-200 ease-out': true,
    'scale-105 shadow-lg': isHovered.value && !isPressed.value,
    'scale-95': isPressed.value,
    'hover:shadow-pink-200/50': true
  }));

  return {
    isHovered,
    isPressed,
    hoverClasses,
    handleMouseEnter,
    handleMouseLeave,
    handleMouseDown,
    handleMouseUp
  };
}

// Loading animation
export function useLoadingAnimation() {
  const isLoading = ref(false);

  const startLoading = () => {
    isLoading.value = true;
  };

  const stopLoading = () => {
    isLoading.value = false;
  };

  const loadingClasses = computed(() => ({
    'animate-pulse': isLoading.value,
    'opacity-50 pointer-events-none': isLoading.value
  }));

  return {
    isLoading,
    loadingClasses,
    startLoading,
    stopLoading
  };
}

// Stagger animation untuk list items
export function useStaggerAnimation(delay = 100) {
  const items = ref<HTMLElement[]>([]);

  const animateItems = () => {
    items.value.forEach((item, index) => {
      if (item) {
        item.style.animationDelay = `${index * delay}ms`;
        item.classList.add('animate-fade-in-up');
      }
    });
  };

  return {
    items,
    animateItems
  };
}

// Floating animation
export function useFloatingAnimation() {
  const floatingClasses = computed(() => ({
    'animate-float': true,
    'hover:animate-none': true
  }));

  return {
    floatingClasses
  };
}

// Ripple effect
export function useRippleEffect() {
  const createRipple = (event: MouseEvent) => {
    const button = event.currentTarget as HTMLElement;
    const rect = button.getBoundingClientRect();
    const size = Math.max(rect.width, rect.height);
    const x = event.clientX - rect.left - size / 2;
    const y = event.clientY - rect.top - size / 2;

    const ripple = document.createElement('span');
    ripple.style.cssText = `
      position: absolute;
      width: ${size}px;
      height: ${size}px;
      left: ${x}px;
      top: ${y}px;
      background: rgba(236, 72, 153, 0.3);
      border-radius: 50%;
      transform: scale(0);
      animation: ripple 0.6s ease-out;
      pointer-events: none;
      z-index: 1;
    `;

    button.style.position = 'relative';
    button.style.overflow = 'hidden';
    button.appendChild(ripple);

    setTimeout(() => {
      ripple.remove();
    }, 600);
  };

  return {
    createRipple
  };
}

// Shake animation untuk error states
export function useShakeAnimation() {
  const isShaking = ref(false);

  const shake = () => {
    isShaking.value = true;
    setTimeout(() => {
      isShaking.value = false;
    }, 500);
  };

  const shakeClasses = computed(() => ({
    'animate-shake': isShaking.value
  }));

  return {
    isShaking,
    shakeClasses,
    shake
  };
}

// Bounce animation
export function useBounceAnimation() {
  const isBouncing = ref(false);

  const bounce = () => {
    isBouncing.value = true;
    setTimeout(() => {
      isBouncing.value = false;
    }, 1000);
  };

  const bounceClasses = computed(() => ({
    'animate-bounce': isBouncing.value
  }));

  return {
    isBouncing,
    bounceClasses,
    bounce
  };
}

// Gradient animation
export function useGradientAnimation() {
  const gradientClasses = computed(() => ({
    'bg-gradient-to-r from-pink-500 to-rose-500': true,
    'bg-size-200 animate-gradient': true,
    'hover:bg-gradient-to-l hover:from-rose-500 hover:to-pink-500': true
  }));

  return {
    gradientClasses
  };
}

// Typewriter effect
export function useTypewriterEffect(text: string, speed = 100) {
  const displayText = ref('');
  const isTyping = ref(false);

  const startTyping = () => {
    isTyping.value = true;
    displayText.value = '';
    
    let i = 0;
    const timer = setInterval(() => {
      if (i < text.length) {
        displayText.value += text.charAt(i);
        i++;
      } else {
        clearInterval(timer);
        isTyping.value = false;
      }
    }, speed);
  };

  return {
    displayText,
    isTyping,
    startTyping
  };
}

// Parallax effect
export function useParallaxEffect(speed = 0.5) {
  const parallaxRef = ref<HTMLElement | null>(null);
  const offset = ref(0);

  const updateParallax = () => {
    if (parallaxRef.value) {
      const rect = parallaxRef.value.getBoundingClientRect();
      offset.value = rect.top * speed;
    }
  };

  onMounted(() => {
    window.addEventListener('scroll', updateParallax);
    updateParallax();
  });

  onUnmounted(() => {
    window.removeEventListener('scroll', updateParallax);
  });

  const parallaxStyle = computed(() => ({
    transform: `translateY(${offset.value}px)`
  }));

  return {
    parallaxRef,
    parallaxStyle
  };
}