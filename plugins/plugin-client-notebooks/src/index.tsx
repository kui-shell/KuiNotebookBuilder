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

import React from 'react'

import { inBrowser } from '@kui-shell/core'
import { Kui, KuiProps, ContextWidgets, MeterWidgets, CurrentWorkingDirectory, SpaceFiller } from '@kui-shell/plugin-client-common'

import { CurrentContext, CurrentNamespace } from '@kui-shell/plugin-kubectl/components'
import { ProxyOfflineIndicator } from '@kui-shell/plugin-proxy-support'
import { Search } from '@kui-shell/plugin-electron-components'

import { productName } from '@kui-shell/client/config.d/name.json'
import autoplay from '@kui-shell/client/config.d/autoplay.json'

/**
 * We will set this bit when the user dismisses the Welcome to Kui
 * tab, so as to avoid opening it again and bothering that user for
 * every new Kui window.
 *
 */
// const welcomeBit = 'plugin-client-default.welcome-was-dismissed'

/**
 * Format our body, with extra status stripe widgets
 *   - <ProxyOfflineIndicator />
 *
 */
export default function renderMain(props: KuiProps) {
  return (
    <Kui
      noHelp
      productName={productName}
      lightweightTables
      {...props}
      toplevel={!inBrowser() && <Search />}
      commandLine={
        props.commandLine || autoplay.length === 0 ? [] : [
          'replay',
          '-r',
          ...autoplay.map(notebook => `/kui/${notebook}`)
        ]
      }
    >
      <ContextWidgets>
      </ContextWidgets>

      <SpaceFiller />

      <MeterWidgets>
        {inBrowser() && <ProxyOfflineIndicator />}
      </MeterWidgets>
    </Kui>
  )
}
