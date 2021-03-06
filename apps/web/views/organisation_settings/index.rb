# frozen_string_literal: true

module Web
  module Views
    module OrganisationSettings
      class Index
        include Web::View

        def settings_active_class
          'active'
        end

        def breadcrumb
          html.nav('aria-label' => 'breadcrumb') do
            ol(class: 'breadcrumb') do
              li(class: 'breadcrumb-item', 'aria-current' => 'page') { 'Settings' }
            end
          end
        end

        def invite_form
          form_for :invite, routes.organisation_invites_path(params[:slug]), method: :post, class: 'form-inline needs-validation', novalidate: true do
            text_field :inviter_id, type: 'hidden', value: current_account.id

            div(class: 'form-group mr-2') do
              text_field :github_or_email, placeholder: 'Github name or email', class: 'form-control', required: true
            end

            submit 'Invite user', class: 'btn btn-success'
          end
        end

        def organisation_member
          organisation_accounts.select { |member| member.account_id == current_account.id }.first
        end
      end
    end
  end
end
