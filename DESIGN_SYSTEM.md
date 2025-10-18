# Klinik Bungas Design System

## Overview
Design system untuk aplikasi Klinik Bungas dengan tema **Pink Kalem dan Elegan** yang mencerminkan kehangatan, kepercayaan, dan profesionalisme dalam layanan kesehatan.

## Brand Identity

### Logo
- **Primary Logo**: Kombinasi ikon hati dengan salib medis
- **Simbolisme**: Hati melambangkan kasih sayang dan kepedulian, salib medis melambangkan profesionalisme kesehatan
- **Tagline**: "Caring with Love"

### Brand Values
- 💖 **Caring**: Peduli dan penuh kasih sayang
- 🏥 **Professional**: Profesional dalam layanan kesehatan
- 🌸 **Gentle**: Lembut dan menenangkan
- ✨ **Elegant**: Elegan dan berkelas

## Color Palette

### Primary Colors
```css
/* Pink Palette */
--pink-50: #fdf2f8;    /* Background subtle */
--pink-100: #fce7f3;   /* Background light */
--pink-200: #fbcfe8;   /* Border light */
--pink-300: #f9a8d4;   /* Text muted */
--pink-400: #f472b6;   /* Accent */
--pink-500: #ec4899;   /* Primary */
--pink-600: #db2777;   /* Primary dark */
--pink-700: #be185d;   /* Text strong */
--pink-800: #9d174d;   /* Text stronger */

/* Rose Palette */
--rose-50: #fff1f2;
--rose-100: #ffe4e6;
--rose-200: #fecdd3;
--rose-300: #fda4af;
--rose-400: #fb7185;
--rose-500: #f43f5e;
--rose-600: #e11d48;
--rose-700: #be123c;
```

### Neutral Colors
```css
--gray-50: #f9fafb;
--gray-100: #f3f4f6;
--gray-200: #e5e7eb;
--gray-300: #d1d5db;
--gray-400: #9ca3af;
--gray-500: #6b7280;
--gray-600: #4b5563;
--gray-700: #374151;
--gray-800: #1f2937;
--gray-900: #111827;
```

## Typography

### Font Family
- **Primary**: Instrument Sans (Modern, clean, friendly)
- **Fallback**: ui-sans-serif, system-ui, sans-serif

### Font Scales
```css
/* Headings */
.text-3xl { font-size: 1.875rem; line-height: 2.25rem; } /* 30px */
.text-2xl { font-size: 1.5rem; line-height: 2rem; }     /* 24px */
.text-xl { font-size: 1.25rem; line-height: 1.75rem; }  /* 20px */
.text-lg { font-size: 1.125rem; line-height: 1.75rem; } /* 18px */

/* Body */
.text-base { font-size: 1rem; line-height: 1.5rem; }    /* 16px */
.text-sm { font-size: 0.875rem; line-height: 1.25rem; } /* 14px */
.text-xs { font-size: 0.75rem; line-height: 1rem; }     /* 12px */
```

### Font Weights
- **Light**: 300 (untuk teks sekunder)
- **Regular**: 400 (untuk body text)
- **Medium**: 500 (untuk labels, captions)
- **Semibold**: 600 (untuk subheadings)
- **Bold**: 700 (untuk headings)

## Components

### Buttons

#### Primary Button
```css
.btn-primary {
  background: linear-gradient(135deg, #ec4899, #f43f5e);
  color: white;
  padding: 0.75rem 1.5rem;
  border-radius: 0.75rem;
  font-weight: 600;
  transition: all 0.2s ease;
}

.btn-primary:hover {
  transform: translateY(-1px);
  box-shadow: 0 10px 25px rgba(236, 72, 153, 0.3);
}
```

#### Secondary Button
```css
.btn-secondary {
  background: rgba(236, 72, 153, 0.1);
  color: #db2777;
  border: 1px solid rgba(236, 72, 153, 0.2);
  padding: 0.75rem 1.5rem;
  border-radius: 0.75rem;
  font-weight: 500;
}
```

### Form Elements

#### Input Fields
```css
.form-input {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid rgba(236, 72, 153, 0.2);
  border-radius: 0.75rem;
  padding: 0.875rem 1rem;
  transition: all 0.2s ease;
}

.form-input:focus {
  border-color: #ec4899;
  box-shadow: 0 0 0 3px rgba(236, 72, 153, 0.1);
  outline: none;
}
```

### Cards
```css
.card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 1.5rem;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
}
```

## Gradients

### Background Gradients
```css
/* Primary Background */
.bg-gradient-primary {
  background: linear-gradient(135deg, #fdf2f8 0%, #fce7f3 50%, #fdf2f8 100%);
}

/* Card Gradients */
.bg-gradient-card {
  background: linear-gradient(135deg, #ec4899 0%, #f43f5e 100%);
}

/* Text Gradients */
.text-gradient {
  background: linear-gradient(135deg, #db2777 0%, #e11d48 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
```

## Animations

### Micro Animations
```css
/* Fade In Up */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Float */
@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
}

/* Glow Pulse */
@keyframes glowPulse {
  0%, 100% { box-shadow: 0 0 20px rgba(236, 72, 153, 0.3); }
  50% { box-shadow: 0 0 30px rgba(236, 72, 153, 0.6); }
}
```

### Hover Effects
```css
/* Lift Effect */
.hover-lift:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

/* Glow Effect */
.hover-glow:hover {
  box-shadow: 0 0 20px rgba(236, 72, 153, 0.4);
}

/* Scale Effect */
.hover-scale:hover {
  transform: scale(1.05);
}
```

## Spacing System

### Padding & Margin Scale
```css
/* Based on 0.25rem (4px) increments */
.p-1 { padding: 0.25rem; }    /* 4px */
.p-2 { padding: 0.5rem; }     /* 8px */
.p-3 { padding: 0.75rem; }    /* 12px */
.p-4 { padding: 1rem; }       /* 16px */
.p-6 { padding: 1.5rem; }     /* 24px */
.p-8 { padding: 2rem; }       /* 32px */
.p-12 { padding: 3rem; }      /* 48px */
```

## Border Radius

### Rounded Corners
```css
.rounded-sm { border-radius: 0.125rem; }  /* 2px */
.rounded { border-radius: 0.25rem; }      /* 4px */
.rounded-md { border-radius: 0.375rem; }  /* 6px */
.rounded-lg { border-radius: 0.5rem; }    /* 8px */
.rounded-xl { border-radius: 0.75rem; }   /* 12px */
.rounded-2xl { border-radius: 1rem; }     /* 16px */
.rounded-3xl { border-radius: 1.5rem; }   /* 24px */
```

## Shadows

### Box Shadows
```css
/* Subtle */
.shadow-sm { box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05); }

/* Default */
.shadow { box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06); }

/* Medium */
.shadow-md { box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); }

/* Large */
.shadow-lg { box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05); }

/* Extra Large */
.shadow-xl { box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04); }

/* Pink Glow */
.shadow-pink { box-shadow: 0 10px 25px rgba(236, 72, 153, 0.3); }
```

## Responsive Design

### Breakpoints
```css
/* Mobile First Approach */
/* xs: 0px */
/* sm: 640px */
/* md: 768px */
/* lg: 1024px */
/* xl: 1280px */
/* 2xl: 1536px */
```

### Mobile Optimizations
- Touch-friendly button sizes (minimum 44px)
- Readable font sizes (minimum 16px for inputs)
- Adequate spacing for touch targets
- Simplified navigation patterns

## Accessibility

### Color Contrast
- All text meets WCAG AA standards (4.5:1 ratio)
- Interactive elements have sufficient contrast
- Focus states are clearly visible

### Focus Management
```css
.focus-ring {
  outline: 2px solid transparent;
  outline-offset: 2px;
}

.focus-ring:focus {
  outline: 2px solid #ec4899;
  outline-offset: 2px;
}
```

## Usage Guidelines

### Do's
✅ Use pink tones for primary actions and branding
✅ Maintain consistent spacing using the 4px grid system
✅ Apply subtle animations to enhance user experience
✅ Use gradients sparingly for emphasis
✅ Ensure sufficient contrast for readability

### Don'ts
❌ Don't overuse bright pink colors
❌ Don't mix different pink hue families
❌ Don't use animations that are too fast or distracting
❌ Don't compromise accessibility for aesthetics
❌ Don't use more than 3 different font weights in one view

## Component Library

### Available Components
- `KlinikBungasLogo` - Brand logo with variants
- `BrandElements` - Watermarks, badges, decorative elements
- `FloatingElements` - Background decorative elements
- `GradientCard` - Reusable card component
- `MedicalIcons` - Medical-themed icon set
- `ResponsiveTest` - Testing component for responsiveness

### Animation Composables
- `useScrollAnimation` - Scroll-triggered animations
- `useHoverAnimation` - Hover effects
- `useLoadingAnimation` - Loading states
- `useStaggerAnimation` - Staggered list animations
- `useFloatingAnimation` - Floating elements
- `useRippleEffect` - Button ripple effects

## Implementation Notes

### CSS Architecture
- Utility-first approach with Tailwind CSS
- Custom CSS for complex animations
- CSS custom properties for theme consistency
- Responsive design with mobile-first approach

### Performance Considerations
- Optimized SVG icons
- Efficient CSS animations using transform and opacity
- Lazy loading for non-critical animations
- Reduced motion support for accessibility

---

*Design System v1.0 - Klinik Bungas*
*Last updated: January 2025*