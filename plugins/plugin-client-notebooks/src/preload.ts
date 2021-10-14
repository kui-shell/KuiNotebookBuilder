/*
 * Copyright 2020 The Kubernetes Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import autoplay from '@kui-shell/client/config.d/autoplay.json'

/**
 * Register the welcome notebook
 *
 */
export default async () => {
  const { notebookVFS } = await import('@kui-shell/plugin-core-support')
  notebookVFS.cp(undefined, autoplay.map(notebook => (
    `plugin://client/notebooks/${notebook}`
  )), '/kui')
}
