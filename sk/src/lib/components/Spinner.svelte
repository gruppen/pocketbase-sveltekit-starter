<script lang="ts" module>
  import { writable } from "svelte/store";

  // returns a store that:
  // starts out false
  // becomes true when the async function f starts running
  // becomes false when f resolves (or rejects)
  export function activityStore<T>(f: (t: T) => Promise<any>) {
    const store = writable(false);
    async function run(data: T) {
      try {
        store.set(true);
        return await f(data);
      } finally {
        store.set(false);
      }
    }
    return { ...store, run };
  }
</script>

<script lang="ts">
  let { active }: { active: boolean } = $props();
</script>

<!--
  @component
  ```svelte
  <Spinner 
  ```
 -->
<span class="loader" class:active></span>

<style lang="scss">
  .loader {
    width: 1em;
    height: 1em;
    border: 0.2em solid var(--links);
    border-radius: 50%;
    display: inline-block;
    box-sizing: border-box;
    &.active {
      border-bottom-color: transparent; // 3/4 border solid, 1/4 transparent
      animation: rotation 1s linear infinite;
    }
  }

  @keyframes rotation {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
</style>
