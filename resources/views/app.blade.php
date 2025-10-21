<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" @class(['dark' => ($appearance ?? 'system') == 'dark'])>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        {{-- 🌓 Dark mode detection --}}
        <script>
            (function() {
                const appearance = '{{ $appearance ?? "system" }}';
                if (appearance === 'system') {
                    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
                    if (prefersDark) {
                        document.documentElement.classList.add('dark');
                    }
                }
            })();
        </script>

        {{-- 🪄 Fallback background --}}
        <style>
            html { background-color: oklch(1 0 0); }
            html.dark { background-color: oklch(0.145 0 0); }
        </style>

        <title inertia>{{ config('app.name', 'Laravel') }}</title>

        {{-- 🧭 Favicon --}}
        <link rel="icon" href="/favicon.ico" sizes="any">
        <link rel="icon" href="/favicon.svg" type="image/svg+xml">
        <link rel="apple-touch-icon" href="/apple-touch-icon.png">

        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=instrument-sans:400,500,600" rel="stylesheet" />

        {{-- Load Vite build (manifest.json) with safe guards and fallback --}}
        @php
            $entry = null;
            $manifestPath = public_path('build/manifest.json');

            if (is_file($manifestPath) && is_readable($manifestPath)) {
                $manifestJson = json_decode(file_get_contents($manifestPath), true);
                if (is_array($manifestJson)) {
                    $entry = $manifestJson['resources/js/app.ts'] ?? null;
                }
            }
        @endphp

        @if ($entry)
            @if (!empty($entry['css']))
                @foreach ($entry['css'] as $css)
                    <link rel="stylesheet" href="{{ asset('build/' . ltrim($css, '/')) }}">
                @endforeach
            @endif
            <script type="module" src="{{ asset('build/' . ltrim($entry['file'], '/')) }}"></script>
        @else
            @vite(['resources/css/app.css', 'resources/js/app.ts'])
        @endif

        @inertiaHead
    </head>

    <body class="font-sans antialiased">
        @inertia
    </body>
</html>
