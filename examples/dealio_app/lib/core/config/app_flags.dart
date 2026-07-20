class AppFlags {
  // Performance-first visual mode:
  // true  -> disables expensive mobile blur/glow/list entrance animations
  // false -> enables richer glass/animation effects for higher-end devices
  static const bool reduceExpensiveVisualEffects = bool.fromEnvironment(
    'REDUCE_EXPENSIVE_VISUAL_EFFECTS',
    defaultValue: false,
  );
}
